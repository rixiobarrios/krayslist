# == Schema Information
#
# Table name: listings
#
#  id          :bigint           not null, primary key
#  details     :text
#  image       :string
#  sold        :boolean          default(FALSE), not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  buyer_id    :integer
#  category_id :integer
#  seller_id   :integer
#
class Listing < ApplicationRecord
  
  mount_uploader :image, ImageUploader

  has_many(:messages, :class_name => "Message", :foreign_key => "listing_id", :dependent => :destroy)
  belongs_to(:seller, :required => true, :class_name => "User", :foreign_key => "seller_id")
  belongs_to(:buyer, :required => false, :class_name => "User", :foreign_key => "buyer_id")
  belongs_to(:category, :required => true, :class_name => "Category", :foreign_key => "category_id")
  # belongs_to(:location, through: "Category", source: "location_id")
end
