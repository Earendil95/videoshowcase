# frozen_string_literal: true

describe SeasonsController do
  specify { expect(get: "/seasons").to route_to(controller: "seasons", action: "index") } # rubocop:disable RSpec/ExpectActual

  describe "GET #index" do
    subject(:response) { get :index, params: params }

    let_it_be(:season) { create :season, created_at: 1.day.ago }
    let_it_be(:new_season) { create :season }
    let_it_be(:new_purchase_option) { create :purchase_option, content: new_season }
    let_it_be(:new_episode_2) { create :episode, season: new_season, number: 2 }
    let_it_be(:new_episode_1) { create :episode, season: new_season, number: 1 }
    let(:params) { {} }

    specify { expect(response).to be_successful }

    it "returns correct values", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
      # season attributes
      expect(response.body).to be_json_eql(new_season.id).at_path("seasons/0/id")
      expect(response.body).to be_json_eql(new_season.title.to_json).at_path("seasons/0/title")
      expect(response.body).to be_json_eql(new_season.plot.to_json).at_path("seasons/0/plot")
      expect(response.body).to be_json_eql(new_season.created_at.to_i)
        .at_path("seasons/0/created_at")
      expect(response.body).to be_json_eql(new_season.number).at_path("seasons/0/number")

      # purchase options
      expect(response.body).to be_json_eql(new_purchase_option.id)
        .at_path("seasons/0/purchase_options/0/id")
      expect(response.body).to be_json_eql(new_purchase_option.quality.to_json)
        .at_path("seasons/0/purchase_options/0/quality")
      expect(response.body).to be_json_eql(new_purchase_option.price.to_f / 100)
        .at_path("seasons/0/purchase_options/0/price")

      # episodes
      expect(response.body).to be_json_eql(new_episode_1.id).at_path("seasons/0/episodes/0/id")
      expect(response.body).to be_json_eql(new_episode_1.title.to_json)
        .at_path("seasons/0/episodes/0/title")
      expect(response.body).to be_json_eql(new_episode_1.plot.to_json)
        .at_path("seasons/0/episodes/0/plot")
      expect(response.body).to be_json_eql(new_episode_1.number)
        .at_path("seasons/0/episodes/0/number")
      expect(response.body).to be_json_eql(new_episode_1.created_at.to_i)
        .at_path("seasons/0/episodes/0/created_at")
      expect(response.body).to be_json_eql(new_episode_2.id)
        .at_path("seasons/0/episodes/1/id")
      expect(response.body).to be_json_eql(season.id).at_path("seasons/1/id")
    end

    context "with pagination" do
      let(:params) { Hash[per_page: 1, page: 1] }

      it "returns only one record" do
        expect(response.body).to have_json_size(1).at_path("seasons")
      end
    end

    context "N + 1", :n_plus_one do # rubocop:disable RSpec/ContextWording
      populate { |n| create_list :season, n }

      specify { expect { get :index }.to perform_constant_number_of_queries }
    end
  end
end
