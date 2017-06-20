User.create!(name:  'Example User',
             email: 'example@railstutorial.org',
             nickname: 'example',
             password:              'foobar',
             password_confirmation: 'foobar',
             admin: true,
             activated: true,
             activated_at: Time.current)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  nickname = "example_#{n + 1}"
  password = 'password'
  User.create!(name:  name,
               email: email,
               nickname: nickname,
               password:              password,
               password_confirmation: password, activated: true,
               activated_at: Time.current)
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.microposts.create!(content: content) }
end

users = User.all
user = users.first

following = users[2..50]
followers = users[3..40]

following.each {|followed| user.follow(followed) }
followers.each {|follower| follower.follow(user) }

room = Room.create!

room.create_room(users[0], users[1])

users[0].message.create(room_id: room.id, content: 'Hello!')
