module Api
  module V1
    class DoctorsController < ApplicationController

      def search
        response = BetterDoctorService.call(search_params)
        render json: response
      end

      private

      def search_params
        params.permit(:name)
      end
    end
  end
end