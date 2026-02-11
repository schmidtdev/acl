%w[me.read users.read users.create users.update users.delete].each do |k|
  Permission.find_or_create_by!(key: k)
end

u = User.first
u.permissions << Permission.find_by!(key: 'me.read') if u && !u.can?('me.read')
