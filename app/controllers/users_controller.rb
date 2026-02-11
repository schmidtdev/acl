class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    authorize User
    users = policy_scope(User)
    render json: UsersSerializer.new(users).as_json
  end

  def show
    authorize @user
    render json: UserSerializer.new(@user).as_json
  end

  def create
    authorize User
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user).as_json, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    authorize @user

    attrs = user_params.to_h
    if attrs["password"].blank?
      attrs.except!("password", "password_confirmation")
    end

    if @user.update(attrs)
      render json: UserSerializer.new(@user).as_json
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @user
    @user.destroy!
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
