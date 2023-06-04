class RosterTeamSerializer
  include JSONAPI::Serializer
  attributes :user_league_id, :api_team_id
end
