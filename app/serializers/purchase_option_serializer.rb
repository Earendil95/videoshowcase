# frozen_string_literal: true

# serializer for purchase options
class PurchaseOptionSerializer < ActiveModel::Serializer
  attributes :id, :quality, :price

  def price
    object.price.to_f / 100
  end
end
