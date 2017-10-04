module Api
  module V1
    module Merchants
      class RevenueController < ApplicationController
        def show
          # render json: Merchant.joins(:transactions).where(transactions: {result: "success"}).joins(:invoice_items).first.invoice_items.sum("unit_price * quantity")
          render json: Merchant.joins(:transactions, :invoice_items).where(transactions: {result: "success"}).sum("invoice_items.quantity*invoice_items.unit_price")
        end
      end
    end
  end
end
