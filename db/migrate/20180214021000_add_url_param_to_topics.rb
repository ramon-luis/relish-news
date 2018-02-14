class AddUrlParamToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :url_param, :string
  end
end
