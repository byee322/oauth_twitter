class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps
    end
    create_table :tweets do |t|
        t.string :status
        t.references :user
        t.string :error_message

        t.timestamps
      end
  end
end
