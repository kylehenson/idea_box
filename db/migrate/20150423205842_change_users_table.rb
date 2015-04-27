class ChangeUsersTable < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :password,:password_confirmation
    end
  end

    def change
      add_column :users, :password_digest, :string
  end
end
