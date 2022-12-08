![index](https://user-images.githubusercontent.com/55994508/206535514-f5608a60-63ba-4ee4-9779-7e8d50530371.png)
![home](https://user-images.githubusercontent.com/55994508/206535532-0b0721b1-c771-405a-b32f-295cbb2d1966.png)
![categories](https://user-images.githubusercontent.com/55994508/206535554-9add02e7-4136-4a68-9296-d2ef23b21557.png)
![show](https://user-images.githubusercontent.com/55994508/206535581-c15a86a5-e4d1-4013-b8a2-8a815db3a589.png)

1. Generate scaffold resources:

a. Listings
```
rails generate scaffold listing seller_id:integer buyer_id:integer title:string details:text image:string category_id:integer
```

Direct Associations:
```
has_many(:messages, :class_name => "Message", :foreign_key => "listing_id", :dependent => :destroy)
belongs_to(:seller, :required => true, :class_name => "User", :foreign_key => "seller_id")
belongs_to(:buyer, :required => false, :class_name => "User", :foreign_key => "buyer_id")
belongs_to(:category, :required => true, :class_name => "Category", :foreign_key => "category_id")
```
b. Categories
```
rails generate scaffold category title:string location_id:integer
```
Direct Associations: 
```
has_many(:listings, :class_name => "Listing", :foreign_key => "category_id", :dependent => :destroy)
belongs_to(:location, :required => true, :class_name => "Location", :foreign_key => "location_id")
```
c. Locations
```
rails generate scaffold location city:string
```
Direct Associations: 
```
has_many(:categories, :class_name => "Category", :foreign_key => "location_id", :dependent => :destroy)
```
d. Messages
```
rails generate scaffold message listing_id:integer sender_id:integer recipient_id:integer body:string
```
Direct Associations: 
```
belongs_to(:listing, :required => true, :class_name => "Listing", :foreign_key => "listing_id")
belongs_to(:sender, :required => true, :class_name => "User", :foreign_key => "sender_id")
belongs_to(:recipient, :required => true, :class_name => "User", :foreign_key => "recipient_id")
```
Make any chamges to migrate files before running db:migrate
```
rails db:migrate
```
2. Generate user devise account 

a. Add ```gem 'devise'``` to your Gemfile

b. Run ```bundle install```

c. stop and restart your server by pressing ```ctrl + c``` and Run ```bin/server```

d. Run ```rails g devise:install```

e. Run ```rails generate devise user username:string avatar:string``

f. Run ```rails db:migrate```

g. show all views for devise 
   ```rails g devise:views```

h. allow additional parameters through security
```
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, :keys => [:username, :avatar])
    
    devise_parameter_sanitizer.permit(:account_update, :keys => [:username, :avatar])
  end
end
```
i. add associations
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
3. Install annotate to visualize tables/models
```
rails g annotate:install
```

a. Run ```rails annotate_models```

4. Make landing page all categories under routes
```
root 'categories#index'
```
5. Added conditional navigation to application.html.erb
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
6. Added fields for user forms edit and new
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
7. Added image to user edit form
```
  <div class="avatar">
    <%= image_tag @user.avatar %>
  </div>
```
8. Add humanize helper to created_at
```
<td><%= time_ago_in_words(listings.created_at) %> ago</td>
```
9. Add image upload capability

a. Install carrierwave
```gem "carrierwave"```

b. Run ```bundle install```

c. Add this tho your ```config/environment.rb```
``` require "carrierwave/orm/activerecord" ```

d. Generate an uploader
```rails generate uploader Avatar```
```rails generate uploader Image```

e. Restart the server bin/server

f. Mount the uploader in the User model
```
class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
end
```
f.1. Mount the uploader in the Listing model
```
class Listing < ApplicationRecord
  mount_uploader :image, ImageUploader
end
```
g. Enhance the forms

g.1. Add enctype to avatar image forms for new and edit
```
<%= form_for(resource, as: resource_name, enctype: "multipart/form-data", url: registration_path(resource_name), html: { method: :put }) do |f| %>
```
g.2. Add file_field to avatar field
```
<%= f.file_field :avatar, autofocus: true, autocomplete: "avatar" %>
```
g.3. Add enctype to listing image partial form ```_form.html.erb```
```
<%= form_with(model: listing, enctype: "multipart/form-data") do |form| %>
```
g.4. Add file_field to image field
```
<%= form.file_field :image %>
```

7. Add notice and alert to application.html.erb, delete notices on all files
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
