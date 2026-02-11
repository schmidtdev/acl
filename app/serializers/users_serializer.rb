class UsersSerializer
  def initialize(users)
    @users = users
  end

  def as_json(*)
    @users.map { |user| UserSerializer.new(user).as_json }
  end
end