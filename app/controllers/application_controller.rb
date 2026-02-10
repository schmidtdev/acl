class ApplicationController < ActionController::API
    include Pundit
    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError do
        render json: { error: 'forbidden' }, status: :forbidden
    end
end
