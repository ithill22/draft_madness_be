class UserLeagueSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id, :league_id
end
