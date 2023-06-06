class UserLeague < ApplicationRecord
  before_create :set_user_name
  
  validates_presence_of :user_id, :league_id, :user_name
  belongs_to :user
  belongs_to :league
  has_many :roster_teams


  private

  def set_user_name
    self.user_name = User.find(user_id).name
  end
end