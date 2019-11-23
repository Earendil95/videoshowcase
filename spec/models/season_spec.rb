# frozen_string_literal: true

require "rails_helper"

describe Season do
  specify { is_expected.to have_many(:episodes) }

  it_validates_presence_of(:title, :plot, :number)
  specify { is_expected.to validate_numericality_of(:number).is_greater_than(0) }
end
