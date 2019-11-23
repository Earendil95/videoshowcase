# frozen_string_literal: true

# Serializer for Purchasing
class PurchasingSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :expires_at

  has_one :content, serializer: ContentSerializer
  has_one :purchase_option, serializer: PurchaseOptionSerializer

  %i[created_at expires_at].each do |field|
    define_method field do
      object.public_send(field).to_i
    end
  end
end
