# Use Factory Girl
Factory.define :user do |user|
  user.name   "Test User"
  user.email  "testuser@foo.bar"
  user.password "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo Bar"
  micropost.about_id 1 
  micropost.association :user
end



