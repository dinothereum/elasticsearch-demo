class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :full_name
      t.date :dob
      t.string :height
      t.string :weight
      t.text :information
      t.integer :position
      t.references :nation, foreign_key: true

      t.timestamps
    end
  end
end
