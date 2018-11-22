class Player < ApplicationRecord
  belongs_to :nation

  has_many :player_clubs, dependent: :destroy
  has_many :clubs, through: :player_clubs

  enum position: [:GK, :CB, :RB, :LB, :CM, :DM, :RM, :LM, :AM, :SS, :LW, :RW, :CF]

  searchkick

  rails_admin do
    configure :player_clubs do
      visible false
    end
  end

  def search_data
    {
      name: name,
      full_name: full_name,
      dob: dob,
      height: height,
      weight: weight,
      clubs: clubs.pluck(:name),
      nation: nation.name,
      continent: nation.continent,
      position: position,
      club_ids: clubs.pluck(:id),
      nation_id: nation.id,
      position_id: Player.positions[position],
      continent_id: continent_id,
    }
  end

  def continent_id
    Nation.continents[nation.continent]
  end
end
