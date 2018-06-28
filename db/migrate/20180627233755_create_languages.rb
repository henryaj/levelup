class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name
      t.references :reviews
      t.references :users

      t.timestamps
    end
    add_index :languages, :name, unique: true
  end
end
