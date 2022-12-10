
![krayslist5](https://user-images.githubusercontent.com/55994508/206867976-7633ae54-6d3c-4186-a314-4ff624fcf459.png)


# Welcome to my final project: Krayslist by Rixio Barrios

![dpi](https://user-images.githubusercontent.com/55994508/206869103-d10c2b8c-29af-4e35-aee7-f5391b5d07db.png)![uis](https://user-images.githubusercontent.com/55994508/206870942-07dbdc5f-0a94-47f8-bff4-3e0e9d7491de.png)

This project is an final assignment for the Software Engineering Apprenticeship provided by the Discovery Partners Institute and the University of Illinois System.

## Concept

Krayslist is my attempt to make the popular classifieds advertisement website **Craigslist** a bit less boring.

## Overview

This application starts at a locations menu to then move you to a categories page to finally put you in an index of listings.
You may pick your desire listing and read more about it.
In order to post an add you would first need to create a new user account.

**Note: You are able to upload images for your listing!**

## Wireframes

![home](https://user-images.githubusercontent.com/55994508/206535532-0b0721b1-c771-405a-b32f-295cbb2d1966.png)
![categories](https://user-images.githubusercontent.com/55994508/206535554-9add02e7-4136-4a68-9296-d2ef23b21557.png)
![index](https://user-images.githubusercontent.com/55994508/206535514-f5608a60-63ba-4ee4-9779-7e8d50530371.png)
![show](https://user-images.githubusercontent.com/55994508/206535581-c15a86a5-e4d1-4013-b8a2-8a815db3a589.png)

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

## Generate scaffold resources:

* Listings
```
rails generate scaffold listing seller_id:integer buyer_id:integer title:string details:text image:string category_id:integer sold:boolean
```

* Direct Associations:
```
has_many(:messages, :class_name => "Message", :foreign_key => "listing_id", :dependent => :destroy)
belongs_to(:seller, :required => true, :class_name => "User", :foreign_key => "seller_id")
belongs_to(:buyer, :required => false, :class_name => "User", :foreign_key => "buyer_id")
belongs_to(:category, :required => true, :class_name => "Category", :foreign_key => "category_id")
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

* Locations
```
rails generate scaffold location city:string
```
- Direct Associations: 
```
has_many(:categories, :class_name => "Category", :foreign_key => "location_id", :dependent => :destroy)
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
- Make any chamges to migrate files before running db:migrate
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

* Make landing page all categories under routes
```
root 'categories#index'
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

* Add dynamic routes
