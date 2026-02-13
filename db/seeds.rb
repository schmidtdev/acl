permission_keys = %w[
  me.read
  users.read
  users.create
  users.update
  users.delete
  user_permissions.read
  user_permissions.manage
]

permissions = permission_keys.map do |key|
  Permission.find_or_create_by!(key: key)
end

master_email = ENV.fetch("MASTER_EMAIL", "master@acl.local")
master_password = ENV.fetch("MASTER_PASSWORD", "password")

master = User.find_or_initialize_by(email: master_email)

if master.new_record?
  master.password = master_password
  master.password_confirmation = master_password
  master.save!

  puts "Created master user with email: #{master_email} and password: #{master_password}"
else
  puts "Master user already exists with email: #{master_email}"
end

missing_permissions = permissions - master.permissions.to_a
master.permissions << missing_permissions if missing_permissions.any?

puts "Assigned all permissions to master user."