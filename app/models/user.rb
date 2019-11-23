# frozen_string_literal: true

# model for users
class User < ApplicationRecord
  # For better search using index users on email
  # we don't use `uniqueness: { case_sensitive: false }` here
  # becase in this case we should add unique index on `LOWER(email)` instead of `email`
  # which will be useless for searching
  # so we just use `before_validation`
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  before_validation :sanitize_email

  private

  def sanitize_email
    email&.downcase!&.strip!
  end
end
