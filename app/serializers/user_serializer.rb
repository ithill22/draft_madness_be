class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :google_id, :auth_token
end
