module Api
  module V1
    module Invoices
      class MerchantsController < ApplicationController
        def show
          render json: Invoice.find(params[:id]).merchants
        end
      end
    end
  end
end
