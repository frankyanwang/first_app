class AddTokenAuthenticatableToUser < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      t.token_authenticatable
    end
    add_index :users, :authentication_token, :unique => true

    User.all.each{ |user|
      if !user.authentication_token
        user.reset_authentication_token!
      end
    }
    
  end
  
  def down
    remove_index :users, :authentication_token
    remove_column :users, :authentication_token
  end
end
