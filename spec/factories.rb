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

Factory.define :horse do |horse|
  horse.name          "Test horse"
  horse.owner_id      1 
  horse.sire_id       2 
  horse.dam_id        3 
  horse.bloodline     "Cigar"
  horse.foal_year     2005 
  horse.foal_country  "USA"
  horse.color         "brown"
  horse.breed         "thoroughbred"
  horse.gender        "stallion"
  horse.markings      "Even"
  horse.photo_file_name "horse_0.jpg"
end

Factory.define :player do |player|
  player.name         "Test Player"
  player.email        "test_player@gmail.com"
  player.user_id      5 
  player.team         "Black Knights"
  player.handicap     3 
  player.age          28 
  player.tel          "212 767 5566"
  player.address      "46 Plaza Colon"
  player.city         "Buenes Aires"
  player.country      "Argentina"
  player.professional true 
  player.photo_file_name  "player_0.jpg" 
  player.cv_file_name     "player_0_cv.pdf"
end

Factory.define :micropost do |micropost|
  micropost.content     "Foo Bar"
  micropost.about_id    1 
  micropost.association :user
end



