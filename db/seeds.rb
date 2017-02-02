# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create!(admin?: 1, email: "admin@admin.com", password: "123456", sign_in_count: 0, created_at: Time.zone.now.to_datetime, updated_at: Time.zone.now.to_datetime)
Entity.create(name: "admin", type_id: admin.id, type_type: User)