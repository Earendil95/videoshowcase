# frozen_string_literal: true

# Model for seasons
class Season < Content
  validates :number, presence: true, numericality: { greater_than: 0 }
end
