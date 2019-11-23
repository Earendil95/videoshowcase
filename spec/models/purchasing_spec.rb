# frozen_string_literal: true

describe Purchasing do
  specify { is_expected.to belong_to(:user) }
  specify { is_expected.to belong_to(:purchase_option) }
  specify { is_expected.to belong_to(:content) }

  it_validates_presence_of(:expires_at)

  context "when validating uniqueness" do
    subject { build :purchasing, user: user, purchase_option: purchase_option }

    let_it_be(:purchasing) { create :purchasing }
    let_it_be(:user) { purchasing.user }
    let_it_be(:purchase_option) { purchasing.purchase_option }

    specify { is_expected.to be_invalid }

    context "when old purchasing is expired" do
      around { |ex| Timecop.travel(3.days.from_now, &ex) }

      specify { is_expected.to be_valid }
    end
  end
end
