# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create!(name: 'Administrator', code: 'ADMIN')
Role.create!(name: 'Staff', code: 'STAFF')
Role.create!(name: 'Student', code: 'STU')

# College.create!(name: 'College of Engineering', short_form: 'COE', code: 'COE')

Semester.create!(sem: 'SEMESTER 1')
Semester.create!(sem: 'SEMESTER 2')
Semester.create!(sem: 'SEMESTER 3')
Semester.create!(sem: 'SEMESTER 4')
Semester.create!(sem: 'SEMESTER 5')
Semester.create!(sem: 'SEMESTER 6')
Semester.create!(sem: 'SEMESTER 7')
Semester.create!(sem: 'SEMESTER 8')

AdminUser.create!(email: Rails.application.credentials.admin[:EMAIL], password: Rails.application.credentials.admin[:PASSWORD], password_confirmation: Rails.application.credentials.admin[:PASSWORD])