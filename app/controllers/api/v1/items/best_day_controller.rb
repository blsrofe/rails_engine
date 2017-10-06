module Api
  module V1
    module Items
      class BestDayController < ApplicationController

        def show
          render json: Item.find(params[:id]).best_day, serializer: BestDaySerializer
        end

      end
    end
  end
end
