# Use Factory Girl
Factory.define :user do |user|
  user.name   "Test User"
  user.email  "testuser@foo.bar"
end

Factory.define :horse do |horse|
  horse.name  "Test Horse"
  horse.breeder_id 10
  horse.sire_id     7
  horse.dam_id      11
  horse.owner       "Horse Owner 1"
  horse.foal_year   1990
  horse.foal_country  "USA"
  horse.color         "brown"
  horse.breed         "thoroughbred"
  horse.stallion      true 
  horse.vet_report_file_name   "vr.pdf"
  horse.xray_file_name         "x.pdf"
  horse.dna_file_name          "dna.pdf"
  horse.registration_file_name "reg.pdf"
  horse.photo_file_name        "photo.jpg"
  horse.content_type           "image/jpg"
  horse.photo_file_size        32000 
end

