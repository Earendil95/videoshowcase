# frozen_string_literal: true

require "rails_helper"

describe Movie do
  it_validates_presence_of(:title, :plot)

  it "validates that number is nil" do
    movie = build :movie, number: 3
    expect(movie).to be_invalid
  end
end
