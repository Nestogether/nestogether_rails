# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  organizer_id :integer
#  group_size   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name         :string
#  discription  :text
#  state        :string
#  type         :string
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
