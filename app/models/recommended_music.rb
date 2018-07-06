class RecommendedMusic < ApplicationRecord
  # associations
  belongs_to :personality

  # delegates
  delegate :name, to: :personality, allow_nil: true, prefix: true
end
