# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Role.create!(name: 'Administrator', code: 'ADMIN')
Role.create!(name: 'Student', code: 'STU')
Role.create!(name: 'Faculty', code: 'FAC')

# College.create!(name: 'College of Engineering', short_form: 'COE', code: 'COE')

Semester.create!(sem: 'SEMESTER 1')
Semester.create!(sem: 'SEMESTER 2')
Semester.create!(sem: 'SEMESTER 3')
Semester.create!(sem: 'SEMESTER 4')
Semester.create!(sem: 'SEMESTER 5')
Semester.create!(sem: 'SEMESTER 6')
Semester.create!(sem: 'SEMESTER 7')
Semester.create!(sem: 'SEMESTER 8')
