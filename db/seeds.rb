Comment.destroy_all
Item.destroy_all
Event.destroy_all
User.destroy_all
Role.destroy_all

Role.create!(name: 'Пользователь', code: :default)

hash_users = 10.times.map do
  {
    name: FFaker::Internet.user_name[1...15],
    email: FFaker::Internet.safe_email,
    role: Role.find_by(code: :default)
  }
end

users = User.create! hash_users

hash_events = 20.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    content: FFaker::HipsterIpsum.paragraphs,
    user: users.sample
  }
end

events = Event.create! hash_events
hash_items = 200.times.map do
  {
    name: FFaker::HipsterIpsum.paragraph,
    event: events.sample
  }
end
Item.create! hash_items

hash_comments = 200.times.map do
  commentable = (rand(2) == 1 ? events : users).sample
  {
    content: FFaker::Lorem.paragraph,
    user: users.sample,
    commentable_id: commentable.id,
    commentable_type: commentable.class.to_s
  }
end

Comment.create! hash_comments
