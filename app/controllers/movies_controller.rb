# frozen_string_literal: true

# Controller for movies
class MoviesController < ApplicationController
  def index
    collection = Movie.includes(:purchase_options)
                      .page(params[:page])
                      .per(params[:per_page])
                      .order(created_at: :desc)

    render_paginated_json collection
  end
end
