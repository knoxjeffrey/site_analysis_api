require 'rails_helper'

describe Api::V1::UserProjectsController do

  describe "GET index" do

    let!(:user) { Fabricate(:user) }
    let!(:project_1) { Fabricate(:project, admin: user, project_name: "Test Project") }
    let!(:project_2) { Fabricate(:project, admin: user, project_name: "Next Project") }
    let!(:user_project_1) { Fabricate(:user_project, user: user, project: project_1) }
    let!(:user_project_2) { Fabricate(:user_project, user: user, project: project_2) }

    context "with valid access token" do

      let(:token) { double :acceptable? => true, :scopes => [:api],
                    :resource_owner_id => user.id }

      before do
        allow(controller).to receive(:doorkeeper_token) {token}
      end

      it "returns the information about the users projects in a hash" do
        get :index, format: :json
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response.first[:project_id]).to eq project_1.id
        expect(project_response.second[:project_id]).to eq project_2.id
      end

      it "returns a 200 response code" do
        get :index, format: :json
        expect(response.code).to eq("200")
      end

    end

    context "with invalid access token" do

      let(:token) { double :acceptable? => true, :scopes => [:api],
                    :resource_owner_id => user.id }

      it "returns a 401 response code" do
        get :index, format: :json
        expect(response.code).to eq("401")
      end

    end

  end

end