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
class Message < ApplicationRecord
  
  belongs_to(:listing, :required => true, :class_name => "Listing", :foreign_key => "listing_id")
  belongs_to(:sender, :required => true, :class_name => "User", :foreign_key => "sender_id")
  belongs_to(:recipient, :required => true, :class_name => "User", :foreign_key => "recipient_id")
end
