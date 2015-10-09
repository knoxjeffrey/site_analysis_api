include ActionView::Helpers::TextHelper # allows pluralize to be used in this controller

module Api

  module V1
    class ProjectsController < ApiController

      def create
        project = Project.new(project_params)
        project.admin = current_resource_owner

        if project.save
          UserProject.create(user: current_resource_owner, project: project)
          render json: project, status: 201
        else
          render json: { errors: parse_errors(project.errors) }, status: 422
        end
      end

      def show
        project = Project.find(params[:id])
        render json: project, status: 200
      end

      private

      def project_params
        params.require(:project).permit(:project_name)
      end

      def parse_errors(errors)
        error_msg_array = errors[errors.keys.first.to_s]
        "#{pluralize(error_msg_array.length, 'error')}: #{error_list(error_msg_array)}"
      end

      def error_list(error_array)
        errors = []
        error_array.each do |error|
          errors << "Project name #{error}"
        end
        errors.to_sentence
      end

    end
  end

end