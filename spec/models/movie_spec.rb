# frozen_string_literal: true

require "rails_helper"

describe Movie do
  specify { is_expected.to have_many(:purchase_options) }

  it_validates_presence_of(:title, :plot)

  it "validates that number is nil" do
    movie = build :movie, number: 3
    expect(movie).to be_invalid
  end
end
