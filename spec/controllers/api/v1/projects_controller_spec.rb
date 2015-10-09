require 'rails_helper'

describe Api::V1::ProjectsController do

  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "GET show" do

    let!(:user) { Fabricate(:user) }
    let!(:project) { Fabricate(:project, admin: user, project_name: "Test Project") }

    context "with a valid access token" do

      let(:token) { double :acceptable? => true, :scopes => [:api] }

      before do
        allow(controller).to receive(:doorkeeper_token) {token}
      end

      it "returns the information about a project in a hash" do
        get :show, id: project.id, format: :json
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:project_name]).to eql "Test Project"
      end

    end

    context "with an invalid access token" do

      let(:token) { double :acceptable? => false, :scopes => [:api] }

      it "returns a 401 response code" do
        get :show, id: project.id, format: :json
        expect(response.code).to eq("401")
      end

    end

  end

end