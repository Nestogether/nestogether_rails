# == Schema Information
#
# Table name: user_group_ships
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  status     :integer          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserGroupShipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
