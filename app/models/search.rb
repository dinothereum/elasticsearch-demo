class Search
  include ActiveModel::Model

  attr_accessor :player_name, :clubs, :nations, :continents, :positions,
    :height_min, :height_max, :weight_min, :weight_max, :age_min, :age_max,
    :birth_year

  def initialize attributes
    if attributes.present?
      attributes.each do |key, value|
        send "#{key}=", value
      end
    end
  end
end
