require 'rails_helper'

describe Api::V1::ProjectsController do

  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "POST create" do

    let!(:user) { Fabricate(:user) }

    context "with a valid access token" do

      let(:token) { double :acceptable? => true, :scopes => [:api],
                    :resource_owner_id => user.id }

      before do
        allow(controller).to receive(:doorkeeper_token) {token}
        post :create, project: Fabricate.attributes_for(:project), format: :json
      end

      it "creates a new project" do
        expect(Project.count).to eq(1)
      end

      it "creates a new project associated with the user" do
        project_response = JSON.parse(response.body, symbolize_names: true)
        expect(project_response[:admin_id]).to eq user.id
      end

      it "returns a 201 response code" do
        expect(response.code).to eq("201")
      end

    end

    context "with an invalid access token" do

      let(:token) { double :acceptable? => false, :scopes => [:api],
                    :resource_owner_id => user.id }

      it "does not create a new project" do
        post :create, project: Fabricate.attributes_for(:project), format: :json
        expect(Project.count).to eq(0)
      end

      it "returns a 401 response code" do
        post :create, project: Fabricate.attributes_for(:project), format: :json
        expect(response.code).to eq("401")
      end


    end

  end

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

      it "returns a 200 response code" do
        get :show, id: project.id, format: :json
        expect(response.code).to eq("200")
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