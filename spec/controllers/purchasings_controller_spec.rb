# frozen_string_literal: true

describe PurchasingsController do
  # rubocop:disable RSpec/ExpectActual
  specify { expect(post: "/purchasings").to route_to(controller: "purchasings", action: "create") }
  specify { expect(get: "/purchasings").to route_to(controller: "purchasings", action: "index") }
  # rubocop:enable RSpec/ExpectActual

  let_it_be(:user) { create :user }
  let_it_be(:movie) { create :movie }
  let_it_be(:purchase_option) { create :purchase_option, content: movie }

  describe "POST #create" do
    subject(:creation) { post :create, params: params }

    let(:params) { Hash[user_id: user.id, purchase_option_id: purchase_option.id] }

    specify { is_expected.to be_successful }
    specify { expect { creation }.to change(Purchasing, :count).by(1) }

    it "responds with purchasing", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
      expect(creation.body).to be_json_eql(movie.id).at_path("purchasing/content/id")
      expect(creation.body).to be_json_eql("Movie".to_json).at_path("purchasing/content_type")
      expect(creation.body).to be_json_eql(movie.title.to_json).at_path("purchasing/content/title")
      expect(creation.body).to be_json_eql(movie.plot.to_json).at_path("purchasing/content/plot")
      expect(creation.body).to be_json_eql(purchase_option.quality.to_json)
        .at_path("purchasing/purchase_option/quality")
      expect(creation.body).to have_json_path("purchasing/id")
      expect(creation.body).to have_json_path("purchasing/expires_at")
      expect(creation.body).to have_json_path("purchasing/created_at")
    end

    context "when content is season" do
      let(:season) { create :season, episodes_count: 1 }
      let(:purchase_option) { create :purchase_option, content: season }
      let(:params) { Hash[user_id: user.id, purchase_option_id: purchase_option.id] }

      it "responds with purchasing", :aggregate_failures do # rubocop:disable RSpec/ExampleLength
        expect(creation.body).to be_json_eql(season.id).at_path("purchasing/content/id")
        expect(creation.body).to be_json_eql("Season".to_json).at_path("purchasing/content_type")
        expect(creation.body).to be_json_eql(season.title.to_json).at_path("purchasing/content/title")
        expect(creation.body).to be_json_eql(season.plot.to_json).at_path("purchasing/content/plot")
        expect(creation.body).to be_json_eql(season.number).at_path("purchasing/content/number")
        expect(creation.body).to have_json_size(1).at_path("purchasing/content/episodes")
      end
    end

    context "when active purchasing exists" do
      before_all { create :purchasing, user: user, purchase_option: purchase_option }

      specify { expect(creation).to be_unprocessable }
      specify { expect { creation }.not_to change(Purchasing, :count) }

      it "responds with error message" do
        expect(creation.body).to have_json_path("errors")
      end
    end

    context "when expired purchasing exists" do
      before_all do
        create :purchasing, user: user, purchase_option: purchase_option, expires_at: 1.day.ago
      end

      specify { is_expected.to be_successful }
      specify { expect { creation }.to change(Purchasing, :count).by(1) }
    end
  end

  describe "GET #index" do
    subject(:response) { get :index, params: params }

    let_it_be(:purchasing) { create :purchasing, user: user }
    let_it_be(:second_purchasing) { create :purchasing, user: user, expires_at: 1.day.from_now }

    let(:params) { Hash[user_id: user.id] }

    specify { is_expected.to be_successful }

    it "returns correct values", :aggregate_failures do
      # checking only order because fields were checked above
      expect(response.body).to be_json_eql(second_purchasing.id).at_path("purchasings/0/id")
      expect(response.body).to be_json_eql(purchasing.id).at_path("purchasings/1/id")
    end

    context "with pagination" do
      let(:params) { Hash[per_page: 1, page: 1, user_id: user.id] }

      it "returns only one record" do
        expect(response.body).to have_json_size(1).at_path("purchasings")
      end
    end

    context "N + 1", :n_plus_one do # rubocop:disable RSpec/ContextWording
      populate { |n| create_list :purchasing, n, user: user }

      specify do
        # we need warming up because we have @user ||= ...
        expect { get :index, params: { user_id: user.id } }
          .to perform_constant_number_of_queries.with_warming_up
      end
    end
  end
end
