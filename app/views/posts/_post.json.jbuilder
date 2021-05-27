json.extract! post, :id, :content, :slug, :user_id, :course_id, :created_at, :updated_at
json.url post_url(post, format: :json)
