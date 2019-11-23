# frozen_string_literal: true

# Base class for Movie and Season. It does some basic validations
class Content < ApplicationRecord
  validates :title, :plot, presence: true
end
