class UserLeague < ApplicationRecord
  validates_presence_of :user_id, :league_id
  belongs_to :user
  belongs_to :league
  has_many :roster_teams
end