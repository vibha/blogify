class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|

      t.string :name
      t.text :description
      t.references :blog, :author, :category
      t.datetime :published_date
      t.string :workflow_state
      t.timestamps
    end
  end
end
