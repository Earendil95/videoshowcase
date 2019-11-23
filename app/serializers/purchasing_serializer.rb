# frozen_string_literal: true

# Serializer for Purchasing
class PurchasingSerializer < ActiveModel::Serializer
  include DateTimeAttributes

  attributes :id, :content_type
  date_time_attributes :created_at, :expires_at

  has_one :content
  has_one :purchase_option, serializer: PurchaseOptionSerializer

  def content_type
    object.content.type
  end
end
