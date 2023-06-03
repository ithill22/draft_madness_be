class League < ApplicationRecord
  validates_presence_of :name, :draft_time, :draft_date, :manager_id
  has_many :user_leagues
  has_many :users, through: :user_leagues
  has_many :roster_teams, through: :user_leagues
end