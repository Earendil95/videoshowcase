# frozen_string_literal: true

# Model for purhcasings. Shows who purchased what and when
class Purchasing < ApplicationRecord
  belongs_to :user
  belongs_to :purchase_option
  belongs_to :content

  validates :expires_at, presence: true
  validate :unique_active_purchasing

  scope :active, -> { where("expires_at > ?", Time.current) }

  private

  def unique_active_purchasing
    return unless Purchasing.active.where(user: user, content: content).exists?

    errors.add(:content, :purchased)
  end
end
