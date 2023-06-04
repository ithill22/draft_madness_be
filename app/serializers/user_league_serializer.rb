class UserLeagueSerializer
  include JSONAPI::Serializer
  attributes :user_id, :league_id
end
