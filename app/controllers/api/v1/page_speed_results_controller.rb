module Api

  module V1

    class PageSpeedResultsController < ApiController

      def index
        project = Project.find(params[:id])
        render json: project.page_speed_results, status: 200
      end

      def create
        @project = Project.find(params[:id])
        @page_speed_form = PageSpeedForm.new(page_speed_form_params)

        is_form_valid?
      rescue GooglePageSpeedAPI::RequestFailure => e
        render json: { errors: e.message }, status: 422
      end

      def show
        page_speed_insight = PageSpeedResult.find(params[:id])
        render json: page_speed_insight, status: 200
      end

      private

      def page_speed_form_params
        params.require(:page_speed_form).permit(:site_address, strategy: [])
      end

      def is_form_valid?
        if @page_speed_form.valid?
          site_analysis_array = page_speed_api_client.create_page_speed_insight(web_address, strategies_selected)
          store_results(site_analysis_array)

          render json: site_analysis_array, status: 201
        else
          render json: { errors: parse_error(@page_speed_form.errors) }, status: 422
        end
      end

      def page_speed_api_client
        GooglePageSpeedAPI::Client.new
      end

      def web_address
        params[:page_speed_form][:site_address]
      end

      def strategies_selected
        params[:page_speed_form][:strategy]
      end

      def store_results(site_analysis_array)
        project_id = @project.id
        PageSpeedResult.store_overview_data(site_analysis_array, project_id)
      end

      def parse_error(error)
        if error.keys.first.to_s == "strategy"
          "You must select at least 1 of either mobile or desktop"
        elsif error.keys.first.to_s == "site_address"
          "You must enter a url"
        end
      end

    end

  end

end