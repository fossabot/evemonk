# frozen_string_literal: true

class LoyaltyPointsController < ApplicationController
  def index
    @character = current_user.characters
      .includes(:race, :bloodline, :ancestry, :faction, :alliance, :corporation)
      .find_by!(character_id: params[:character_id])
      .decorate

    @loyalty_points = @character.loyalty_points
      .includes(:corporation)
  end
end
