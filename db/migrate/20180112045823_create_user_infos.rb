class CreateUserInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :user_infos do |t|
      t.string :icon
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
