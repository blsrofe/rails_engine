module Api
  module V1
    module Items
      class RandomController < ApplicationController

        def index
          render json: Item.order("RANDOM()").first
        end

      end
    end
  end
end
