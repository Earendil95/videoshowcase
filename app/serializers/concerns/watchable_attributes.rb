# frozen_string_literal: true

# Module to setup Watchable attributes
module WatchableAttributes
  extend ActiveSupport::Concern

  included do
    include DateTimeAttributes

    attributes :id, :title, :plot
    date_time_attributes :created_at
  end
end
