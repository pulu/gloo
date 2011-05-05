# Use Factory Girl
Factory.define :user do |user|
  user.name   "Test User"
  user.email  "testuser@foo.bar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo Bar"
  micropost.player_id 1 
  micropost.association :user
end

Factory.define :comment do |comment|
  comment.content "Foo Bar"
  comment.horse_id 1 
  comment.association :user
end


