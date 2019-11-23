# frozen_string_literal: true

require "rails_helper"

describe MoviesController do
  specify { expect(get: "/movies").to route_to(controller: "movies", action: "index") } # rubocop:disable RSpec/ExpectActual

  describe "GET #index" do
    subject(:response) { get :index, params: params }

    let_it_be(:movie) { create :movie, created_at: 1.day.ago }
    let_it_be(:new_movie) { create :movie }
    let_it_be(:new_purchase_option) { create :purchase_option, content: new_movie }
    let(:params) { {} }

    specify { expect(response).to be_successful }

    it "returns correct values", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
      expect(response.body).to be_json_eql(new_movie.id).at_path("movies/0/id")
      expect(response.body).to be_json_eql(new_movie.title.to_json).at_path("movies/0/title")
      expect(response.body).to be_json_eql(new_movie.plot.to_json).at_path("movies/0/plot")
      expect(response.body).to be_json_eql(new_movie.created_at.to_i).at_path("movies/0/created_at")
      expect(response.body).to be_json_eql(new_purchase_option.id)
        .at_path("movies/0/purchase_options/0/id")
      expect(response.body).to be_json_eql(new_purchase_option.quality.to_json)
        .at_path("movies/0/purchase_options/0/quality")
      expect(response.body).to be_json_eql(new_purchase_option.price.to_f / 100)
        .at_path("movies/0/purchase_options/0/price")
      expect(response.body).to be_json_eql(movie.id).at_path("movies/1/id")
    end

    context "with pagination" do
      let(:params) { Hash[per_page: 1, page: 1] }

      it "returns only one record" do
        expect(response.body).to have_json_size(1).at_path("movies")
      end
    end

    context "N + 1", :n_plus_one do # rubocop:disable RSpec/ContextWording
      populate { |n| create_list :movie, n }

      specify { expect { get :index }.to perform_constant_number_of_queries }
    end
  end
end
