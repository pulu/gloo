require 'faker'

namespace :db do
  desc "Fill Horse table with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    Horse.create!(  :name => "Sample Horse",
                    :breed => "Thoroughbred",
                    :color => "Black",
                    :gender => "stallion",
                    :breeder_id => 10,
                    :sire_id => 3,
                    :dam_id => 2,
                    :photo_file_name => "horse_1.jpg",
                    :photo_content_type => "image/jpg",
                    :photo_file_size => 4661,
                    :owner => "Owner One")

    35.times do |n|
      name = Faker::Name.name
      breed = %w{Argentinian Criollo Thoroughbred Arabian}.shuffle.first
      color = %w{Black Brown White Bay Grey}.shuffle.first
      photo_no = (n+2)%11
      photo_file_name = "horse_#{photo_no}.jpg"
      gender = %w{Stallion Mare Gelding}.shuffle.first 
      breeder = (1..10).to_a.shuffle.first
      sire = (1..30).to_a.shuffle.first
      dam =  (1..30).to_a.shuffle.first
      owner = Faker::Name.name
      Horse.create!(:name => name,
                    :breed => breed,
                    :color => color,
                    :gender => gender,
                    :photo_file_name => photo_file_name,
                    :photo_content_type => "image/jpeg",
                    :breeder_id => breeder,
                    :sire_id => sire,
                    :dam_id => dam,
                    :owner => owner)

    end
     
    Player.create!( :name => "Ignacio Figuera",
                    :email => "ignaciof@gmail.com",
                    :age => "30",
                    :tel => "001 917 665 2156",
                    :country => "Argentina",
                    :team => "Black Watch",
                    :handicap => 3,
                    :photo_file_name => "player_0.jpg",
                    :photo_content_type => "image/jpg",
                    :photo_file_size => 4661,
                    :professional => true)

    15.times do |n|
      name =  Faker::Name.name
      email = Faker::Internet.email
      tel =   Faker::PhoneNumber.phone_number
      country = Faker::Address.country
      address = Faker::Address.street_address

      team = %w{BlackKnights Rumberos APA TreeFarm Pampas}.shuffle.first
      handicap = (0..3).to_a.shuffle.first
      photo_no = (n+2)%8
      photo_file_name = "player_#{photo_no}.jpg"
      photo_content_type = "image/jpg"
      photo_file_size = 4661
      professional = %w{true false}.shuffle.first 
      age = (18..40).to_a.shuffle.first
      Player.create!(:name => name,
                    :email => email,
                    :country => country,
                    :team => team,
                    :handicap => handicap,
                    :age => age,
                    :address => address,
                    :tel => tel,
                    :professional => professional,
                    :photo_file_name => photo_file_name,
                    :photo_content_type => "image/jpeg")

    end    
  end
end
      
