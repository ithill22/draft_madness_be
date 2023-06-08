class TeamSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :region, :seed, :games_won
end
