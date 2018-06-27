class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :uid
      t.string :git_repo

      t.timestamps
    end
    add_index :reviews, :uid, unique: true
  end
end
