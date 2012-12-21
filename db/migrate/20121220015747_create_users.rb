class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :token
      t.integer :expire
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :users, :uid, :uniq => true
  end
end
