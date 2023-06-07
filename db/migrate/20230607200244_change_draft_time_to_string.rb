class ChangeDraftTimeToString < ActiveRecord::Migration[7.0]
  def change
    change_column :leagues, :draft_time, :string
  end
end
