# frozen_string_literal: true

# Module to setup Watchable attributes
module WatchableAttributes
  extend ActiveSupport::Concern

  included do
    attributes :id, :title, :plot, :created_at
  end

  def created_at
    object.created_at.to_i
  end
end
