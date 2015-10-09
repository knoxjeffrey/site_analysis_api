module Api

  module V1
    class UserProjectsController < ApiController

      def index
        render json: current_resource_owner.user_projects, status: 200
      end

    end
  end

end