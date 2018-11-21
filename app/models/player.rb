class Player < ApplicationRecord
  belongs_to :nation

  has_many :player_clubs, dependent: :destroy
  has_many :clubs, through: :player_clubs

  enum position: [:GK, :CB, :RB, :LB, :CM, :DM, :RM, :LM, :AM, :SS, :LW, :RW, :CF]

  rails_admin do
    configure :player_clubs do
      visible false
    end
  end
end
