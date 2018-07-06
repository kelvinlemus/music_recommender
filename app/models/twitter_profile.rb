class TwitterProfile < ApplicationRecord
  # associaciones
  has_many :personalities
  has_many :recommended_musics
end
