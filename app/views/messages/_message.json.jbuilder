json.extract! message, :id, :listing_id, :sender_id, :recipient_id, :body, :created_at, :updated_at
json.url message_url(message, format: :json)
