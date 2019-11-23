# frozen_string_literal: true

# Base class for Movie and Season. It does some basic validations
class Content < ApplicationRecord
  has_many :purchase_options, inverse_of: :content,
                              foreign_key: :content_id,
                              dependent: :destroy

  # We define this association here, because for example in ContentsController
  # we need to use Content.includes(:episodes) because of inverse association
  # naming we are sure that episode cannot be connected with Movie and
  # Movie will always has 0 episodes
  has_many :episodes, -> { order(:number) }, foreign_key: :season_id,
                                             inverse_of: :season,
                                             dependent: :destroy

  validates :title, :plot, presence: true

  def self.serializer_for(record, _)
    "#{record.type}Serializer".safe_constantize
  end
end
