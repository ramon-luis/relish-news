class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :rank
      t.belongs_to :user, index: true
      t.belongs_to :topic, index: true
      t.timestamps
    end
  end
end
