class CreateRosterTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :roster_teams do |t|
      t.references :user_league, null: false, foreign_key: true
      t.string :api_team_id

      t.timestamps
    end
  end
end
