# frozen_string_literal: true

# Model for seasons
class Season < Content
  has_many :episodes, -> { order(:number) }, dependent: :destroy

  validates :number, presence: true, numericality: { greater_than: 0 }
end
