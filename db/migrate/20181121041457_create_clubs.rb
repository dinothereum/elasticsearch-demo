class CreateClubs < ActiveRecord::Migration[5.0]
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :short_name
      t.string :stadium
      t.references :nation, foreign_key: true

      t.timestamps
    end
  end
end
