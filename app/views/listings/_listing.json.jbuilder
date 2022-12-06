json.extract! listing, :id, :seller_id, :buyer_id, :title, :details, :category_id, :created_at, :updated_at
json.url listing_url(listing, format: :json)
