# frozen_string_literal: true

# Controller for content, mixed of Movies and Seasons
class ContentsController < ApplicationController
  def index
    collection = Content.includes(:purchase_options, :episodes)
                        .page(params[:page])
                        .per(params[:per_page])
                        .order(created_at: :desc)

    # we don't use Content.serializer_for here (method will take serializer name from
    # controller_name) because it will be easier on front end to check `type` field
    # before doing something instead of checking `episodes` field existance
    render_paginated_json collection, root: "contents"
  end
end
