class CreateDogLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :dog_likes do |t|
      t.references :user, foreign_key: true
      t.references :dog, foreign_key: true
      t.timestamps
    end
  end
end
