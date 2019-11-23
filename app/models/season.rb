# frozen_string_literal: true

# Model for seasons
class Season < Content
  has_many :episodes, -> { order(:number) }, dependent: :destroy
  has_many :purchase_options, foreign_key: :content_id,
                              inverse_of: :content,
                              dependent: :destroy

  validates :number, presence: true, numericality: { greater_than: 0 }
end
