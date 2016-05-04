json.array!(@users) do |user|
  json.extract! user, :id, :email, :password_digest, :username
  json.url user_url(user, format: :json)
end
