
![krayslist5](https://user-images.githubusercontent.com/55994508/206867976-7633ae54-6d3c-4186-a314-4ff624fcf459.png)


# Welcome to my final project: Krayslist by Rixio Barrios

![dpi](https://user-images.githubusercontent.com/55994508/206869103-d10c2b8c-29af-4e35-aee7-f5391b5d07db.png)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
![uis](https://user-images.githubusercontent.com/55994508/206870942-07dbdc5f-0a94-47f8-bff4-3e0e9d7491de.png)

This project is an final assignment for the Software Engineering Apprenticeship provided by the Discovery Partners Institute and the University of Illinois System.

## Concept

Krayslist is my attempt to make the popular classifieds advertisement website **Craigslist** a bit less boring.

## Overview

This application starts at a locations menu to then move you to a categories page to finally put you in an index of listings.
You may pick your desire listing and read more about it.
In order to post an add you would first need to create a new user account.

**Note: You are able to upload images for your listing!**

## How to run this application

* Clone this repo
```
git clone https://github.com/rixiobarrios/krayslist.git
```
* Find Ruby version under Gemfile
* Alternatively use Ruby version management tool **Rbenv**
* Install [Homebrew](https://brew.sh) to install **Rbenv**
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
* Install Rbenv
```
brew install rbenv
```
* install Ruby
```
# List Ruby versions available
rbenv install --list
# Install Ruby 2.5.3
rbenv install 2.5.3
# Set a default version.
rbenv global 2.5.3
```
* Install Bundler version
```
# Make sure you are using the desired Ruby version to install.
ruby --version
# To see if you already have Bundler installed
bundler --version
# Or
bundle --version
# This will install the bundler gem in Ruby 2.5.3
gem install bundler -v 2.0.1
```
* Install the required gems
```
bundle install
```
* Setup database
```
bundle e rails db:setup
```
* Run the rails server
```
bundle e rails s
```
**Note: This process may need additional steps depending on your system**

## Data Model

![Screen Shot 2022-12-14 at 6 14 36 PM](https://user-images.githubusercontent.com/55994508/207743286-1d8abee8-6bb6-4a11-b8a0-536bae13f2df.png)

## Wireframes

* Home (Location)
![home](https://user-images.githubusercontent.com/55994508/206535532-0b0721b1-c771-405a-b32f-295cbb2d1966.png)


* Categories
![categories](https://user-images.githubusercontent.com/55994508/206535554-9add02e7-4136-4a68-9296-d2ef23b21557.png)


* Listings
![index](https://user-images.githubusercontent.com/55994508/206535514-f5608a60-63ba-4ee4-9779-7e8d50530371.png)


* Details
![show](https://user-images.githubusercontent.com/55994508/206535581-c15a86a5-e4d1-4013-b8a2-8a815db3a589.png)


* Mobile and PC Screens

<img width="539" alt="Screen Shot 2022-12-14 at 6 31 33 PM" src="https://user-images.githubusercontent.com/55994508/207744715-1c57c1df-377b-4052-af4b-37f01f982718.png">

## Previews

* Begin by choosing location
![1_Location](https://user-images.githubusercontent.com/55994508/219000780-9940d5cb-0928-47be-9556-d6c396387244.png)


* Choose category
![2_Categories](https://user-images.githubusercontent.com/55994508/219001002-d4220996-3f85-4ece-991b-a6d0033b48ed.png)


* View market, see items available and not available
![3_Market](https://user-images.githubusercontent.com/55994508/219001368-751b3daf-04b5-4427-9d85-c0d4c1e9b410.png)


* Choose listing
![4_Listing](https://user-images.githubusercontent.com/55994508/219002676-7fdf3c1d-b6b9-47fe-9b43-cb500d91e90f.png)


* Send message to posting user
![5_Message](https://user-images.githubusercontent.com/55994508/219002683-7520a025-b400-4b03-97fb-8c145fa68dcb.png)


* User edit and sign out options
![6_Profile](https://user-images.githubusercontent.com/55994508/219002684-50ce4643-f1f8-4688-a145-c3df5d3579ec.png)


* User details
![7_User](https://user-images.githubusercontent.com/55994508/219002687-c6c33745-3b96-469c-8fa3-0e39ac860006.png)


* User dashboard
![8_add](https://user-images.githubusercontent.com/55994508/219002692-1c7bde42-752a-4286-aed2-e8399fa69772.png)


* Add new listing
![9_New](https://user-images.githubusercontent.com/55994508/219002695-86d5cbd2-4a55-460a-92ef-222145308f23.png)


* Admin option to add location
![10_Locations](https://user-images.githubusercontent.com/55994508/219002697-d7f9bd6d-6395-4a4a-9b41-571c7c7d0717.png)


* Admin option to add categories
![11_Categories](https://user-images.githubusercontent.com/55994508/219002699-789ea11a-b784-40af-b36f-50fd265385bb.png)


* Admin option to moderate user activity
![12_Users](https://user-images.githubusercontent.com/55994508/219002701-dc32e51e-7b4f-4879-85fc-659a7d52141c.png)


* Admin option to moderate listings
![13_Listings](https://user-images.githubusercontent.com/55994508/219002705-a3b86454-9d34-4c1b-ba2f-b8c344db0f3f.png)


# The building of the app

## Generate scaffold resources

* Locations
```
rails generate scaffold location city:string
```
- Direct Associations: 
```
has_many(:categories, :class_name => "Category", :foreign_key => "location_id", :dependent => :destroy)
```

* Categories
```
rails generate scaffold category title:string location_id:integer
```
- Direct Associations: 
```
has_many(:listings, :class_name => "Listing", :foreign_key => "category_id", :dependent => :destroy)
belongs_to(:location, :required => true, :class_name => "Location", :foreign_key => "location_id")
```

* Listings
```
rails generate scaffold listing seller_id:integer buyer_id:integer title:string details:text image:string category_id:integer sold:boolean
```
**Note: set ```sold:boolean``` to ```default: false, null: false``` on the migration file before running ```rails db:migrate```**

* Direct Associations:
```
has_many(:messages, :class_name => "Message", :foreign_key => "listing_id", :dependent => :destroy)
belongs_to(:seller, :required => true, :class_name => "User", :foreign_key => "seller_id")
belongs_to(:buyer, :required => false, :class_name => "User", :foreign_key => "buyer_id")
belongs_to(:category, :required => true, :class_name => "Category", :foreign_key => "category_id")
```
- Indirect Association:
```
has_one  :location, through: :category, source: :location
```

* Messages
```
rails generate scaffold message listing_id:integer sender_id:integer recipient_id:integer body:string
```
- Direct Associations: 
```
belongs_to(:listing, :required => true, :class_name => "Listing", :foreign_key => "listing_id")
belongs_to(:sender, :required => true, :class_name => "User", :foreign_key => "sender_id")
belongs_to(:recipient, :required => true, :class_name => "User", :foreign_key => "recipient_id")
```
- Make any changes to migrate files before running db:migrate
```
rails db:migrate
```

## Generate user devise account 

* Add ```gem 'devise'``` to your Gemfile

* Run ```bundle install```

- stop and restart your server by pressing ```ctrl + c``` and Run ```bin/server```

* Run ```rails g devise:install```

* Run ```rails generate devise user username:string avatar:string``

* Run ```rails db:migrate```

- show all views for devise 
   ```rails g devise:views```

* Allow additional parameters through security
```
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:username, :avatar])
    
    devise_parameter_sanitizer.permit(:account_update, :keys => [:username, :avatar])
  end
end
```
- Add associations
```
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many(:listing_seller, :class_name => "Listing", :foreign_key => "seller_id", :dependent => :destroy) 
  has_many(:listing_buyer, :class_name => "Listing", :foreign_key => "buyer_id", :dependent => :destroy)
  has_many(:message_sender, :class_name => "Message", :foreign_key => "sender_id", :dependent => :destroy)
  has_many(:message_recipient, :class_name => "Message", :foreign_key => "recipient_id", :dependent => :destroy)      
end
```

* Install annotate to visualize tables/models
```
rails g annotate:install
```
- Run ```rails annotate_models```


* Make landing page all locations under routes
```
root 'locations#index'
```

* Added validations to User model
```
class User < ApplicationRecord
  validates :avatar, presence: true
  validates :username, presence: true
end  
```  

* Added validations to Listing model
```
class User < ApplicationRecord
  validates :image, presence: true
  validates :title, presence: true
end  
```  

* Added conditional navigation to application.html.erb
```
     <!-- conditional for user sessions/rendering links -->
      <% if current_user != nil %>
      <%= link_to "Your listings", listings_path %>
      |
      <%= link_to "Edit profile", edit_user_registration_path %>
      |
      <%= link_to "Sign out", destroy_user_session_path, method: :delete %>
      |
      <%= current_user.username %>
```

* Added fields for user forms edit and new
```
  <div class="field">
    <%= f.label :avatar %><br />
    <%= f.text_field :avatar, autofocus: true, autocomplete: "avatar" %>
  </div>

  <div class="field">
    <%= f.label :username %><br />
    <%= f.text_field :username, autofocus: true, autocomplete: "username" %>
  </div>
```

* Added image to user edit form
```
  <div class="avatar">
    <%= image_tag @user.avatar %>
  </div>
```

* Add humanize helper to created_at
```
<td><%= time_ago_in_words(listings.created_at) %> ago</td>
```

## Add image upload capability

* Install carrierwave
```gem "carrierwave"```

- Run ```bundle install```

- Add this tho your ```config/environment.rb```
``` require "carrierwave/orm/activerecord" ```

- Generate an uploader
```rails generate uploader Avatar```
```rails generate uploader Image```

- Restart the server ```bin/server```

- Mount the uploader in the User model
```
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
end
```
- Mount the uploader in the Listing model
```
class Listing < ApplicationRecord
  mount_uploader :image, ImageUploader
end
```
* Enhance the forms

- Add enctype to avatar image forms for new and edit
```
<%= form_for(resource, as: resource_name, enctype: "multipart/form-data", url: registration_path(resource_name), html: { method: :put }) do |f| %>
```
- Add file_field to avatar field
```
<%= f.file_field :avatar, autofocus: true, autocomplete: "avatar" %>
```
- Add enctype to listing image partial form ```_form.html.erb```
```
<%= form_with(model: listing, enctype: "multipart/form-data") do |form| %>
```
- Add file_field to image field
```
<%= form.file_field :image %>
```

## Add notice and alert to application.html.erb, delete notices on all files
```
    <!-- conditional to avoid duplicate alerts or notices -->
    <% if notice.present? %>
    <div style="color: green;">
      <%= notice %>
    </div>

    <% end %>
    <% if alert.present? %>
    <div style="color: red;">
      <%= alert %>
    </div>

    <% end %>
```

## Add better redirects

* create, update, destroy redirect_to("/listings")
```
format.html { redirect_to listings_path, notice: "Listing was successfully created." }
format.html { redirect_to listings_path, notice: "Listing was successfully updated." }
format.html { redirect_to listings_path, notice: "Listing was successfully destroyed." }    
```
* create, update, destroy redirect_to("/categories")
```
format.html { redirect_to categories_path, notice: "Category was successfully created." }
format.html { redirect_to categories_path, notice: "Category was successfully updated." }
format.html { redirect_to categories_path, notice: "Category was successfully destroyed." }    
```
* create, update, destroy redirect_to("/locations")
```
format.html { redirect_to locations_path, notice: "Location was successfully created." }
format.html { redirect_to locations_path, notice: "Location was successfully updated." }
format.html { redirect_to locations_path, notice: "Location was successfully destroyed." }    
```
* create, update, destroy redirect_to("/messages")
```
format.html { redirect_to messages_path, notice: "Message was successfully created." }
format.html { redirect_to messages_path, notice: "Message was successfully updated." }
format.html { redirect_to messages_path, notice: "Message was successfully destroyed." }    
```

## Add user views for admin

* Add route delow ```devise_for :users```
```
resources :users, only: [:index, :show, :new, :edit, :update]
```
* Create a User controller ```/controllers/users_controller.rb``` and add the following code
```
class UsersController < ApplicationController

  def index
    @users = User.all.order('username ASC')
  end

  def show
    @user = User.find_by!(id: params.fetch(:id))
  end
end
```
* Create a rendering file ```/views/users/index.html.erb``` and add the following code
```
<h1>Users</h1>

<table>
  <thead>
    <tr>
      <th>Avatar</th>
      <th>Username</th>
      <th>Email</th>
      <th>Created</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @users.each do |user| %>
      <tr>
        <td><%= user.avatar %></td>
        <td><%= user.username %></td>
        <td><%= user.email %></td>
        <td><%= time_ago_in_words(user.created_at) %> ago</td>
        <td><%= link_to 'Show', user %></td>
        <td><%= link_to 'Edit', edit_user_path(user) %></td>
        <td><%= link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= link_to 'New user', new_user_path %>
```
* Create a rendering file ```/views/users/show.html.erb``` and add the following code
```
<p>
  <strong>User ID:</strong>
  <%= @user.id %>
</p>

<p>
  <strong>Username:</strong>
  <%= @user.username %>
</p>

<p>
  <strong>Email:</strong>
  <%= @user.email %>
</p>

<p>
  <strong>Avatar:</strong>
  <%= image_tag @user.avatar.url %>
</p>

<p>
  <strong>Created:</strong>
  <%= time_ago_in_words(@user.created_at) %> 
</p>

<p>
  <strong>Updated:</strong>
  <%= time_ago_in_words(@user.updated_at) %> 
</p>

<%= link_to 'Edit', edit_user_registration_path(@user) %> |
<%= link_to 'Back', users_path %>
```

* Add new partial file for notice and alert in ```views/shared/_flash.html.erb```
```
<div class="alert alert-<%= css_class %> alert-dismissible fade show" role="alert">
  <%= message %>

  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>
```

* Add application helper for listing at ```app/assets/helpers/listing_helper.rb```
```
module ListingsHelper
  def humanize_boolean(value)
    case value
    when true
      "Yes"
    when false
      "No"
    when nil
      "Undefined"
    else
      "Invalid"
    end
  end
end
```

* Add dynamic routes

* Add search option

* Add pagination

# Special Thanks

**Discovery Partners Institute Team:**
Jelani Woods, Robert Sfarzo, Raghu Betina, Mathew Kline, Jennifer Foil, Gary Nixon and Morgan Diamond 
