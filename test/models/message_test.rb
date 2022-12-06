# == Schema Information
#
# Table name: messages
#
#  id           :bigint           not null, primary key
#  body         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  listing_id   :integer
#  recipient_id :integer
#  sender_id    :integer
#
require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
