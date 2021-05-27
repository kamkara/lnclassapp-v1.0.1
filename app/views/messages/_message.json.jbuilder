json.extract! message, :id, :content, :slug, :user_id, :course_id, :created_at, :updated_at
json.url message_url(message, format: :json)
