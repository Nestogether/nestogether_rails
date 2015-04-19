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
#

class Group < ActiveRecord::Base
  has_many :user_group_ships
  has_many :users, through: :user_group_ships
  belongs_to :rent_case
  belongs_to :organizer, class_name: :User
  after_create :create_organizer_user_group_ship, if: Proc.new {|group| group.rent_case.type == "TenantRentCase"}

  validates_presence_of :organizer

  def joined_members
    user_group_ships.where(state: "approved").map(&:user) - [organizer]
  end

  def create_organizer_user_group_ship
    self.user_group_ships.create(user: organizer, state: "approved")
  end

end
