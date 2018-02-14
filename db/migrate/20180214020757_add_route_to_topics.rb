class AddRouteToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :route, :string
  end
end
