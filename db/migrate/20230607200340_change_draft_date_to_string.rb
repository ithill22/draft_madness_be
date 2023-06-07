class ChangeDraftDateToString < ActiveRecord::Migration[7.0]
  def change
    change_column :leagues, :draft_date, :string
  end
end
