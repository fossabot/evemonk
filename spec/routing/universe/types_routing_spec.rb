# frozen_string_literal: true

require "rails_helper"

describe Universe::TypesController do
  describe "routing" do
    it "should route GET /universe/types to universe/types#index" do
      expect(get: "/universe/types").to route_to(
        controller: "universe/types",
        action: "index"
      )
    end

    it "should route GET /universe/types/4259 to universe/types#show" do
      expect(get: "/universe/types/4259").to route_to(
        controller: "universe/types",
        action: "show",
        id: "4259"
      )
    end
  end
end
