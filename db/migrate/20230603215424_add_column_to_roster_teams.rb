class AddColumnToRosterTeams < ActiveRecord::Migration[7.0]
  def change
    add_column :roster_teams, :score, :integer
  end
end
