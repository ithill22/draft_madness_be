class RosterTeam < ApplicationRecord
  validates_presence_of :team_id, :user_league_id
  belongs_to :user_league
  has_one :user, through: :user_league
  has_one :league, through: :user_league
end