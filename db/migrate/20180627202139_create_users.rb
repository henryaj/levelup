class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :uid

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end
