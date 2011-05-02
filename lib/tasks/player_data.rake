require 'faker'

namespace :db do
  desc "Fill Player table with sample data"
  task :pop_players => :environment do
    Rake::Task['db:reset'].invoke
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
      
