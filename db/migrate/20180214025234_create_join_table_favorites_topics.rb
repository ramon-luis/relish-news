class CreateJoinTableFavoritesTopics < ActiveRecord::Migration[5.1]
  def change
    create_join_table :favorites, :topics do |t|
      # t.index [:favorite_id, :topic_id]
      # t.index [:topic_id, :favorite_id]
    end
  end
end
