# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  rent_case_id :integer
#  organizer_id :integer
#  group_size   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name         :string
#  discription  :text
#  state        :string
#

class Group < ActiveRecord::Base
  include Workflow

  has_many :user_group_ships
  has_many :users, through: :user_group_ships
  belongs_to :rent_case
  belongs_to :organizer, class_name: :User
  after_create :create_organizer_user_group_ship, if: Proc.new {|group| group.rent_case.type == "TenantRentCase"}

  validates_presence_of :organizer

  workflow_column :state
  workflow do
    state :pending do
      event :activate, transition_to: :activated
    end
    state :activated
    state :expired
  end
# workflow events start
  def activate
    if rent_case.type == "TenantRentCase"
      rent_case.rent!
    end
  end
# workflow events end

  def joined_roommates(option={})
    if option[:include_organizer].present? 
      user_group_ships.with_approved_state.map(&:user) 
    else
      user_group_ships.with_approved_state.map(&:user) - [organizer]
    end
  end

  def has_enough_roommates?
    joined_roommates.size == group_size
  end

  def create_organizer_user_group_ship
    self.user_group_ships.create(user: organizer, state: "approved")
  end

end
