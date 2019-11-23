# frozen_string_literal: true

# Controller for seasons
class SeasonsController < ApplicationController
  def index
    collection = Season.includes(:purchase_options, :episodes)
                       .page(params[:page])
                       .per(params[:per_page])
                       .order(created_at: :desc)

    render_paginated_json collection
  end
end
