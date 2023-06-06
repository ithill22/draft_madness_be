class AddUserNameToUserLeagues < ActiveRecord::Migration[7.0]
  def change
    add_column :user_leagues, :user_name, :string
  end
end
