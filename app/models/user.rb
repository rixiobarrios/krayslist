# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar                 :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(:listing_seller, :class_name => "Listing", :foreign_key => "seller_id", :dependent => :destroy) 
  has_many(:listing_buyer, :class_name => "Listing", :foreign_key => "buyer_id", :dependent => :destroy)
  has_many(:message_sender, :class_name => "Message", :foreign_key => "sender_id", :dependent => :destroy)
  has_many(:message_recipient, :class_name => "Message", :foreign_key => "recipient_id", :dependent => :destroy)      
end
