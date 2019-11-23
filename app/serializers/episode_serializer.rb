# frozen_string_literal: true

# Serializer for episodes
class EpisodeSerializer < ActiveModel::Serializer
  include WatchableAttributes

  attributes :number
end
