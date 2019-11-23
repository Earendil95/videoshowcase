# frozen_string_literal: true

# Model for movies
class Movie < Content
  has_many :purchase_options, inverse_of: :content,
                              foreign_key: :content_id,
                              dependent: :destroy

  validate :number_is_nil

  private

  def number_is_nil
    return if number.nil?

    errors.add(:number, :invalid)
  end
end
