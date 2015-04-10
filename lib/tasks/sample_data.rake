namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
  admin = User.create!(name: "Admin User",
  email: "admin@gmail.com",
  password: "dochub",
  password_confirmation: "dochub",
  admin: true)
  end
end