class LeagueSerializer
  include JSONAPI::Serializer
  attributes :name, :draft_time, :draft_date, :manager_id
end
