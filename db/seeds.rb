%w[me.read users.read users.create users.update users.delete].each do |k|
  Permission.find_or_create_by!(key: k)
end

%w[
  user_permissions.read
  user_permissions.manage
].each { |k| Permission.find_or_create_by!(key: k) }

u = User.first
u.permissions << Permission.find_by!(key: 'me.read') if u && !u.can?('me.read')
