require 'rails_helper'

describe Api::V1::PageSpeedResultsController do

  before(:each) { request.headers['Accept'] = "application/vnd.marketplace.v1" }

  describe "POST create" do

    let!(:user) { Fabricate(:user) }
    let!(:project) { Fabricate(:project) }

    context "with a valid access token" do

      let(:token) { double :acceptable? => true, :scopes => [:api],
                    :resource_owner_id => user.id }

      context "with valid input supplied to Page Speed Insights API" do

        context "for 1 strategy", vcr: true  do

          before do
            allow(controller).to receive(:doorkeeper_token) {token}
            post :create, page_speed_form: Fabricate.attributes_for(:page_speed_form,
              strategy: ["mobile"]), id: project.id, format: :json
          end

          it "returns an array with 1 hash" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response.count).to eql 1
          end

          it "returns a hash key of rule_groups" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response.first[:rule_groups]).not_to be nil
          end

          it "returns a hash key of stats" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response.first[:stats]).not_to be nil
          end

          it "returns a hash key of insights" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response.first[:insights]).not_to be nil
          end

          it "returns a hash key of problems" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response.first[:problems]).not_to be nil
          end

        end

        context "for 2 strategies", vcr: true do

          before do
            allow(controller).to receive(:doorkeeper_token) {token}
            post :create, page_speed_form: Fabricate.attributes_for(:page_speed_form),
              id: project.id, format: :json
          end

          it "returns an array with 2 hashes" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response.count).to eql 2
          end

        end

      end

      context "with invalid input supplied to Page Speed Insights API" do

        context "for the website address", vcr: true do

          before do
            allow(controller).to receive(:doorkeeper_token) {token}
            post :create, page_speed_form: Fabricate.attributes_for(:page_speed_form,
              site_address: "http://www.assfdfdfsf.com"), id: project.id, format: :json
          end

          it "returns a DNS error" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response[:errors]).to eql "DNS error while resolving www.assfdfdfsf.com. Check the spelling of the host, and ensure that the page is accessible from the public Internet."
          end

          it "returns a 422 response code" do
            expect(response.code).to eq("422")
          end

        end

        context "for no strategies selected", vcr: true do

          before do
            allow(controller).to receive(:doorkeeper_token) {token}
            post :create, page_speed_form: Fabricate.attributes_for(:page_speed_form,
              strategy: []), id: project.id, format: :json
          end

          it "returns a DNS error" do
            project_response = JSON.parse(response.body, symbolize_names: true)
            expect(project_response[:errors]).to eql "You must select at least 1 of either mobile or desktop"
          end

          it "returns a 422 response code" do
            expect(response.code).to eq("422")
          end

        end

      end

    end

    context "with an invalid access token" do

      let(:token) { double :acceptable? => false, :scopes => [:api] }

      it "returns a 401 response code" do
        post :create, page_speed_form: Fabricate.attributes_for(:page_speed_form,
          strategy: ["mobile"]), id: project.id, format: :json
        expect(response.code).to eq("401")
      end

    end

  end

end