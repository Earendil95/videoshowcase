# frozen_string_literal: true

# Model for movies
class Movie < Content
  validate :number_is_nil

  private

  def number_is_nil
    return if number.nil?

    errors.add(:number, :invalid)
  end
end
