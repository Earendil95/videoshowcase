# frozen_string_literal: true

# Controller for Purchasings
# #create is for purchasing content by user
# #index is for getting user's library
class PurchasingsController < ApplicationController
  def create
    purchasing = Purchasing.new(purchasing_params)
    if purchasing.save
      render json: purchasing, serializer: PurchasingSerializer
    else
      render json: { errors: purchasing.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    collection = user.purchasings.includes(:purchase_option, :content)
                     .active.order(expires_at: :asc)
                     .page(params[:page]).per(params[:per_page])

    render_paginated_json collection, include: %i[content purchase_option]
  end

  private

  def user
    @user ||= User.find(params[:user_id])
  end

  def purchase_option
    @purchase_option ||= PurchaseOption.find(params[:purchase_option_id])
  end

  def purchasing_params
    {
      user: user,
      purchase_option: purchase_option,
      content: purchase_option.content,
      expires_at: 2.days.from_now
    }
  end
end
