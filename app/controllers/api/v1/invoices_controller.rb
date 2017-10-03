module Api
  module V1
    class InvoicesController < ApplicationController

      def index
        render json: Invoice.all
      end

    end
  end
end
