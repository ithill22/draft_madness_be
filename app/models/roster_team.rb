class RosterTeam < ApplicationRecord
  belongs_to :user_league
  has_one :user, through: :user_league
  has_one :league, through: :user_league
end