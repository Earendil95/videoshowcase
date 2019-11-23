# frozen_string_literal: true

# Serializer for seasons with purchase options and episodes
class SeasonSerializer < ActiveModel::Serializer
  include WatchableAttributes

  has_many :purchase_options, serializer: PurchaseOptionSerializer
  has_many :episodes, serializer: EpisodeSerializer

  attributes :number
end
