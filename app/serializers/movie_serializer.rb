# frozen_string_literal: true

# Serializer for movie with purchase options
class MovieSerializer < ActiveModel::Serializer
  include WatchableAttributes

  has_many :purchase_options, serializer: PurchaseOptionSerializer
end
