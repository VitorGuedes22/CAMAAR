require "rails_helper"

RSpec.describe ClassesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/classes").to route_to("classes#index")
    end

    it "routes to #new" do
      expect(get: "/classes/new").to route_to("classes#new")
    end

    it "routes to #show" do
      expect(get: "/classes/1").to route_to("classes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/classes/1/edit").to route_to("classes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/classes").to route_to("classes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/classes/1").to route_to("classes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/classes/1").to route_to("classes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/classes/1").to route_to("classes#destroy", id: "1")
    end
  end
end
