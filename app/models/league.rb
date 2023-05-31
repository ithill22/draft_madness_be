class League < ApplicationRecord
  has_many :user_leagues
  has_many :users, through: :user_leagues
  has_many :roster_teams, through: :user_leagues
end