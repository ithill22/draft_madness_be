class User < ApplicationRecord
  has_many :user_leagues
  has_many :leagues, through: :user_leagues
  has_many :roster_teams, through: :user_leagues
end