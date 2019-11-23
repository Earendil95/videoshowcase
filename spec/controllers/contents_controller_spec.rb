# frozen_string_literal: true

describe ContentsController do
  specify { expect(get: "/contents").to route_to(controller: "contents", action: "index") } # rubocop:disable RSpec/ExpectActual

  describe "GET #index" do
    subject(:response) { get :index, params: params }

    let_it_be(:movie) { create :movie }
    let_it_be(:season) { create :season, created_at: 1.day.ago }
    let_it_be(:movie_purchase_option) { create :purchase_option, content: movie }
    let_it_be(:season_purchase_option) { create :purchase_option, content: season }
    let(:params) { {} }

    specify { expect(response).to be_successful }

    it "returns correct values", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
      expect(response.body).to be_json_eql(movie.id).at_path("contents/0/id")
      expect(response.body).to be_json_eql(movie.title.to_json).at_path("contents/0/title")
      expect(response.body).to be_json_eql(movie.plot.to_json).at_path("contents/0/plot")
      expect(response.body).to be_json_eql(movie.created_at.to_i).at_path("contents/0/created_at")
      expect(response.body).to be_json_eql("null").at_path("contents/0/number")
      expect(response.body).to be_json_eql(movie_purchase_option.id)
        .at_path("contents/0/purchase_options/0/id")
      expect(response.body).to be_json_eql(movie_purchase_option.quality.to_json)
        .at_path("contents/0/purchase_options/0/quality")
      expect(response.body).to be_json_eql(movie_purchase_option.price.to_f / 100)
        .at_path("contents/0/purchase_options/0/price")
      expect(response.body).to be_json_eql(season.id).at_path("contents/1/id")
      expect(response.body).to be_json_eql(season.number).at_path("contents/1/number")
    end

    context "with pagination" do
      let(:params) { Hash[per_page: 1, page: 1] }

      it "returns only one record" do
        expect(response.body).to have_json_size(1).at_path("contents")
      end
    end

    context "N + 1", :n_plus_one do # rubocop:disable RSpec/ContextWording
      populate do |n|
        create_list :movie, n
      end

      specify { expect { get :index }.to perform_constant_number_of_queries }
    end
  end
end
