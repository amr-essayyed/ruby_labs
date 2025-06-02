class AddReportsCountAndArchivedToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :reports_count, :integer, default: 0, null: false
    add_column :articles, :archived, :boolean, default: false, null: false
  end
end
