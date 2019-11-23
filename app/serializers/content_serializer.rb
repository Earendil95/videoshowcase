# frozen_string_literal: true

# Serializer for Content, mixed of
class ContentSerializer < ActiveModel::Serializer
  include WatchableAttributes

  has_many :purchase_options, serializer: PurchaseOptionSerializer
  has_many :episodes, serializer: EpisodeSerializer

  attributes :number, :type
end
