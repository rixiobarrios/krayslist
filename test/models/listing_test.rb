# == Schema Information
#
# Table name: listings
#
#  id          :bigint           not null, primary key
#  details     :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  buyer_id    :integer
#  category_id :integer
#  seller_id   :integer
#
require "test_helper"

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
