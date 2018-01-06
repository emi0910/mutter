class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.integer :count, default: 0
      t.boolean :public
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :articles, :created_at
  end
end
