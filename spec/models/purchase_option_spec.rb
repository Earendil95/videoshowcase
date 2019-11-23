# frozen_string_literal: true

require "rails_helper"

describe PurchaseOption do
  specify { is_expected.to belong_to(:content) }

  it_validates_presence_of(:price, :quality)
  specify { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
end
