class UserPermissionsController < ApplicationController
  before_action :set_target_user

  def index
    authorize :user_permission, :index?
    render json: @tarfet_user.permissions.order(:key).pluck(:key)
  end

  def create
    authorize :user_permission, :create?

    keys = Array(params[:permission_keys]).map(&:to_s).map(&:strip).reject(&blank?).uniq
    return render json: { error: "No permission keys provided" }, status: :bad_request if keys.empty?

    perms = Permission.where(key: keys).to_a
    found_keys = perms.map(&:key)
    missing = keys - found_keys
    return render json: { error: "Unknown permissions", missing: missing }, status: unprocessable_entity if missing.any?

    current = @target_user.permissions.pluck(:key).to_set
    to_add = perms.reject { |p| current.include?(p.key) }

    @target_user.permissions << to_add if to_add.any?

    render json: {
      user_id: @target_user.id,
      added: to_add.map(&:key),
      total: @target_user.permissions.count
    }, status: :created
  end

  def destroy
    authorize :user_permission, :destroy?

    key = params[:id].to_s

    if @target_user.id == current_user.id && key == "user_permissions.manage"
      return render json: { error: "Cannot remove your own manage permission" }, status: :forbidden
    end

    perm = Permission.find_by(key: key)
    return head :not_found unless perm

    @target_user.permissions.destroy(perm)

    render json: {
      user_id: @target_user.id,
      removed: key,
      total: @target_user.permissions.count
    }
  end

  private

  def set_target_user
    @target_user = User.find(params[:user_id])
  end
end
