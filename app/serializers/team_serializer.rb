class TeamSerializer
  include JSONAPI::Serializer
  attributes :name, :region, :seed
end
