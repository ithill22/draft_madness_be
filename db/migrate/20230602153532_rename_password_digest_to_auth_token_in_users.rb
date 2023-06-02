class RenamePasswordDigestToAuthTokenInUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password_digest, :auth_token
  end
end
