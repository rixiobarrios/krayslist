# require "open-uri"

task sample_data: :environment do
  starting = Time.now
  p "Creating sample data"

  if Rails.env.development?
    Message.delete_all
    Location.delete_all
    Category.delete_all
    Listing.delete_all
    User.delete_all
  end  

  usernames = Array.new { Faker::Name.first_name }

  usernames << "alice"
  usernames << "bob"
  usernames << "emilia"
  usernames << "carol"
  usernames << "ramon"
  usernames << "daren"
  usernames << "albertina"
  usernames << "doug"
  usernames << "inez"
  usernames << "margret"

  # 12.times do
  # 10.times do
  usernames.each do |username|
    # name = Faker::Name.first_name.downcase
    # u = User.create(
      User.create(
      avatar: "https://robohash.org/#{rand(9999)}?set=set3",
      # email: "#{name}@example.com",
      email: "#{username}@example.com",
      # username: name,
      username: username,
      password: "password",
      private: [true, false].sample
    )
    # p u.errors.full_messages
  end 
  # p "#{User.count} users have been created." 

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          # status: ["pending", "accepted", "rejected"].sample
          status: FollowRequest.statuses.keys.sample
        )
      end  

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end  
    end   
  end
  # p "#{FollowRequest.count} follow requests have been created."  

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "https://robohash.org/#{rand(9999)}"
        # image: File.open("https://robohash.org/#{rand(9999)}")
        # image: File.open("https://robohash.org/988")
        # image: URI.open("https://robohash.org/988").read
        # image: URI.open("https://sienaconstruction.com/wp-content/uploads/2017/05/test-image.jpg").read

        # image: "https://robohash.org/988"

      )
      # p photo.errors.full_messages
      if photo.id != nil
        user.followers.each do |follower|
          if rand < 0.5
            photo.fans << follower
          end  

          if rand < 0.25
            photo.comments.create(
              body: Faker::Quote.jack_handey,
              author: follower
            )
            end
          end
        end
      end 
    end

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{Message.count} follow requests."
  p "There are now #{Location.count} photos."
  p "There are now #{Category.count} likes."
  p "There are now #{Listing.count} comments."
end
