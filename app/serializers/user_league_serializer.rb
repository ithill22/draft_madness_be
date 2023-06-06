class UserLeagueSerializer
  include JSONAPI::Serializer
  attributes :user_id, :league_id, :user_name
end
