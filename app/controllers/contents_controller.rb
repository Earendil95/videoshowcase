# frozen_string_literal: true

# Controller for content, mixed of Movies and Seasons
class ContentsController < ApplicationController
  def index
    collection = Content.includes(:purchase_options, :episodes)
                        .page(params[:page])
                        .per(params[:per_page])
                        .order(created_at: :desc)

    render_paginated_json collection, root: "contents"
  end
end
