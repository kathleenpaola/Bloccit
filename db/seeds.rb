require 'faker'

  topics = []
  15.times do
    topics << Topic.create(
      name: Faker::Lorem.words(rand(1..10)).join(" "),
      description: Faker::Lorem.paragraph(rand(1..4))
      )
  end

  u = User.new(
  name: 'Admin User',
  email: 'admin@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

rand(4..10).times do 

  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password)
  u.skip_confirmation!
  u.save 

  rand(5..12).times do 
    topic = topics.first
    p = u.posts.create(
      topic: topic,
      title: Faker::Lorem.words(rand(1..10)).join(" "),
      body: Faker::Lorem.paragraphs(rand(1..4)).join("/n"))

    p.update_attribute(:created_at, Time.now - rand(600..31536000))

    p.update_rank
    topics.rotate!

    rand(3..7).times do
      p.comments.create(
        body: Faker::Lorem.paragraphs(rand(1..2)).join("/n"),
        user_id: u.id
        )

    end       

    topics.rotate!
    
  end
end
#comments = Comment.all 
#all_users = User.all

#comments.each do |comment|
#  user = all_users.first
#  comment.user_id = user.id
#  all_users.rotate!
#  comment.save
#end


puts "Seed finished"
puts "#{User.count} users created" 
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
