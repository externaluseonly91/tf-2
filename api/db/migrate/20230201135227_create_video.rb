class CreateVideo < ActiveRecord::Migration[6.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.references :categories, null: false, foreign_key: true

      t.timestamps
    end
  end
end
