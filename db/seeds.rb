User.create!(name:  "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true)

10.times do |n|
  name  = Faker::LeagueOfLegends.champion
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password,
    is_admin: false)
end

users = User.order(:created_at).take(8)
8.times do
  title = Faker::LeagueOfLegends.rank
  content = Faker::LeagueOfLegends.quote
  users.each { |user| user.posts.create!(title: title, content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
