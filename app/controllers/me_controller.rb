class MeController < ApplicationController
  def show
    authorize :me, :show?
    render json: current_user
  end
end
