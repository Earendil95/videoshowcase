# frozen_string_literal: true

# Model for episodes
class Episode < ApplicationRecord
  belongs_to :season

  validates :title, :plot, :number, presence: true
  validates :number, numericality: { greater_than: 0 }, uniqueness: { scope: :season_id }
end
