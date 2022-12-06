1. Generate scaffold resources:

a. Listings

rails generate scaffold listing seller_id:integer buyer_id:integer title:string details:text category_id:integer

Direct Associations:

has_many(:messages, { :class_name => "Message", :foreign_key => "listing_id", :dependent => :destroy })
belongs_to(:seller, { :required => true, :class_name => "User", :foreign_key => "seller_id" })
belongs_to(:buyer, { :required => true, :class_name => "User", :foreign_key => "buyer_id" })
belongs_to(:category, { :required => true, :class_name => "Category", :foreign_key => "category_id" })

b. Categories

rails generate scaffold category title:string location_id:integer

Direct Associations: 

has_many(:listings, { :class_name => "Listing", :foreign_key => "category_id", :dependent => :destroy })
belongs_to(:location, { :required => true, :class_name => "Location", :foreign_key => "location_id" })

c. Locations

rails generate scaffold location city:string

Direct Associations: 

has_many(:categories, { :class_name => "Category", :foreign_key => "location_id", :dependent => :destroy })

d. Messages

rails generate scaffold message listing_id:integer sender_id:integer recipient_id:integer body:string

Direct Associations: 

belongs_to(:listing, { :required => true, :class_name => "Listing", :foreign_key => "listing_id" })
belongs_to(:sender, { :required => true, :class_name => "User", :foreign_key => "sender_id" })
belongs_to(:recipient, { :required => true, :class_name => "User", :foreign_key => "recipient_id" })

Make any chamges to migrate files before running db:migrate

rails db:migrate

2. Generate user devise account 

Add gem 'devise' to your Gemfile

bundle install

stop and restart your server 
bin/server

rails g devise:install

rails generate devise user username:string avatar:string

rails db:migrate

show all views for devise 
rails g devise:views

3. Install annotate to visualize tables/models

rails g annotate:install

run
rails annotate_models

4. Make landing page all posts under routes

root 'listings#index'

5. Added conditional navigation to application.html.erb
     <!-- conditional for user sessions/rendering links -->
      <% if current_user != nil %>
      <%= link_to "Your posts", posts_path %>
      |
      <%= link_to "Edit profile", edit_user_registration_path %>
      |
      <%= link_to "Sign out", destroy_user_session_path, method: :delete %>