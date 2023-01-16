json.extract! notification, :id, :title, :user_id, :created_at, :updated_at
json.url notification_url(notification, format: :json)
