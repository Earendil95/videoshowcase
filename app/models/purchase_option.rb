# frozen_string_literal: true

# Model for purchase options of Content.
# We use explicit model instead of storing options in the Content
# because in this case we have more freedom
# For example, we can keep this options immutable to know how price was changing over time
# or we can easily add new option (e.g. UHD)
# Also we use integer prices (in cents) to avoid problems like 0.1 + 0.2 == 0.30000000000000004
class PurchaseOption < ApplicationRecord
  belongs_to :content

  validates :price, :quality, presence: true
  validates :price, numericality: { greater_than: 0 }
end
