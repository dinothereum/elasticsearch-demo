class Nation < ApplicationRecord
  enum continent: [:Asia, :Europe, :Australia, :Africa, :"North America", :"South America"]
end
