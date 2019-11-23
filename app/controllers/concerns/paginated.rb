# frozen_string_literal: true

# This module provides methods to easily collect pagination data from paginated collection
# and simplify rendering paginated collection
module Paginated
  def render_paginated_json(collection, **options)
    render json: collection, **default_options(collection).reverse_merge(options)
  end

  def pagination_data(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      total_count: collection.total_count,
      total_pages: collection.total_pages
    }
  end

  private

  def default_options(collection)
    {
      each_serializer: "#{controller_name.singularize.classify}Serializer".safe_constantize,
      meta: pagination_data(collection), meta_key: :pagination
    }
  end
end
