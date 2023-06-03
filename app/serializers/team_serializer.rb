class TeamSerializer
  include JSONAPI::Serializer
  attributes :id, :type, :name, :region, :seed
end
