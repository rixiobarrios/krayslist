# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#
class Category < ApplicationRecord
  
  # has_many(:listings, { :class_name => "Listing", :foreign_key => "category_id", :dependent => :destroy })
  # belongs_to(:location, { :required => true, :class_name => "Location", :foreign_key => "location_id" })
end
