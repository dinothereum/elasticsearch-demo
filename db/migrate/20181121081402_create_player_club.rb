class CreatePlayerClub < ActiveRecord::Migration[5.0]
  def change
    create_table :player_clubs do |t|
      t.date :time_started
      t.date :time_finished
      t.string :goal
      t.references :player, foreign_key: true
      t.references :club, foreign_key: true
    end
  end
end
