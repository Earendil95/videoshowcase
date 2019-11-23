# frozen_string_literal: true

# Base class for Movie and Season. It does some basic validations
class Content < ApplicationRecord
  has_many :purchase_options, dependent: :destroy
  has_many :episodes, foreign_key: :season_id, inverse_of: :season, dependent: :destroy

  validates :title, :plot, presence: true
end
