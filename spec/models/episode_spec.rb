# frozen_string_literal: true

require "rails_helper"

describe Episode do
  specify { is_expected.to belong_to(:season) }

  it_validates_presence_of(:title, :plot, :number)
  specify { is_expected.to validate_numericality_of(:number).is_greater_than(0) }

  context "with uniqueness" do
    subject { create :episode }

    specify { is_expected.to validate_uniqueness_of(:number).scoped_to(:season_id) }
  end
end
