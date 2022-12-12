# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  city       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  
  has_many(:categories, :class_name => "Category", :foreign_key => "location_id", :dependent => :destroy)
  
  has_many(:listings, :through => :categories, :source => :listings)
end
