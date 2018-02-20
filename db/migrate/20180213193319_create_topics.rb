class CreateTopics < ActiveRecord::Migration[5.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :is_query
      t.string :query
      t.string :route
      t.string :url_param
      t.timestamps
    end
  end
end
