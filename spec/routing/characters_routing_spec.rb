# frozen_string_literal: true

require "rails_helper"

describe CharactersController do
  describe "routing" do
    it "should route GET /characters to characters#index" do
      expect(get: "/characters").to route_to(
        controller: "characters",
        action: "index"
      )
    end

    it "should route GET /characters/90729314 to characters#show" do
      expect(get: "/characters/90729314").to route_to(
        controller: "characters",
        action: "show",
        id: "90729314"
      )
    end

    it "should route PUT /characters/90729314 to characters#update" do
      expect(put: "/characters/90729314").to route_to(
        controller: "characters",
        action: "update",
        id: "90729314"
      )
    end

    it "should route PATCH /characters/90729314 to characters#update" do
      expect(patch: "/characters/90729314").to route_to(
        controller: "characters",
        action: "update",
        id: "90729314"
      )
    end

    it "should route DELETE /characters/90729314 to characters#destroy" do
      expect(delete: "/characters/90729314").to route_to(
        controller: "characters",
        action: "destroy",
        id: "90729314"
      )
    end
  end
end
