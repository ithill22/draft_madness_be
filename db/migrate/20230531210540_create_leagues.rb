class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues do |t|
      t.string :name
      t.time :draft_time
      t.date :draft_date
      t.integer :manager_id

      t.timestamps
    end
  end
end
