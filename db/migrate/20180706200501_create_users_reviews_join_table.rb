class CreateUsersReviewsJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews_users, id: false do |t|
      t.integer :review_id
      t.integer :user_id
    end
 
    add_index :reviews_users, :user_id
    add_index :reviews_users, :review_id
  end
end
