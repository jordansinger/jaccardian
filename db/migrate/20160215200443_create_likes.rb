class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :like
      t.boolean :dislike
      t.integer :user_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
