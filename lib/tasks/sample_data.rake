require 'faker'

namespace :db do
  desc "Fill Horse table with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke

    #-----------------------
    Horse.create!(  :name => "Sample Horse",
                    :owner_id => 1,
                    :breed => "Thoroughbred",
                    :color => "Black",
                    :gender => "stallion",
                    :breeder_id => 10,
                    :sire_id => 3,
                    :dam_id => 2,
                    :bloodline => "RedStar",
                    :markings => "White socks",
                    :photo_file_name => "horse_1.jpg",
                    :photo_content_type => "image/jpg",
                    :photo_file_size => 4661
                  )

    @no_breeders = 10
    @no_horses = 25
    @no_horses.times do |n|
      name = Faker::Name.name
      owner_id = 1
      breed = %w{Argentinian Criollo Thoroughbred Arabian}.shuffle.first
      color = %w{Black Brown White Bay Grey}.shuffle.first
      photo_no = (n+2)%11
      photo_file_name = "horse_#{photo_no}.jpg"
      gender = %w{Stallion Mare Gelding}.shuffle.first 
      breeder = (1..@no_breeders).to_a.shuffle.first
      markings = %w{socks white-spots black-spots grey-patch}.shuffle.first
      dam =  (1..@no_horses).to_a.shuffle.first
      sire = (1..@no_horses).to_a.shuffle.first
      hsire = Horse.find(sire) if sire < n
      bloodline = hsire.bloodline if hsire
      bloodline ||= %w{RedStar Pepe Ruby Lluvia Ricardo Escobar}.shuffle.first
      Horse.create!(:name => name,
                    :owner_id => owner_id,
                    :breed => breed,
                    :color => color,
                    :gender => gender,
                    :photo_file_name => photo_file_name,
                    :photo_content_type => "image/jpeg",
                    :breeder_id => breeder,
                    :sire_id => sire,
                    :bloodline => bloodline,
                    :dam_id => dam,
                    :markings => markings)

    end
     
    #---------------------
    Player.create!( :name => "Ignacio Figuera",
                    :user_id => 1,
                    :email => "ignaciof@gmail.com",
                    :age => "30",
                    :tel => "001 917 665 2156",
                    :address => "57 Carlos Casares",
                    :city => "Buenos Aires",
                    :country => "Argentina",
                    :team => "Black Watch",
                    :handicap => 3,
                    :photo_file_name => "player_0.jpg",
                    :photo_content_type => "image/jpg",
                    :photo_file_size => 4661,
                    :cv_file_name => "player_0_cv.pdf",
                    :professional => true)

    @no_players = 15
    @no_players.times do |n|
      name =  Faker::Name.name
      user_id = 1
      email = Faker::Internet.email
      tel =   Faker::PhoneNumber.phone_number
      country = Faker::Address.country
      address = Faker::Address.street_address
      city = Faker::Address.city

      team = %w{BlackKnights Rumberos APA TreeFarm Pampas}.shuffle.first
      handicap = (0..3).to_a.shuffle.first
      photo_no = (n+2)%8
      photo_file_name = "player_#{photo_no}.jpg"
      photo_content_type = "image/jpg"
      photo_file_size = 4661
      cv_file_name = "player_0_cv.pdf"
      professional = %w{true false}.shuffle.first 
      age = (18..40).to_a.shuffle.first
      Player.create!(:name => name,
                    :user_id => user_id,
                    :email => email,
                    :country => country,
                    :team => team,
                    :handicap => handicap,
                    :age => age,
                    :tel => tel,
                    :address => address,
                    :city => city,
                    :professional => professional,
                    :photo_file_name => photo_file_name,
                    :photo_content_type => "image/jpeg",
                    :cv_file_name => cv_file_name 
                    )
    end 

    #------------------
    @no_users = 10
    @no_users.times do |n| 
      name = Faker::Name.first_name
      email = Faker::Internet.email
      password = "abcdefgh"
      password_confirmation = "abcdefgh"
      user = User.create!(:name => name, 
                          :email => email,
                          :password => password,
                          :password_confirmation => password_confirmation
                          )
      @no_microposts = (1..5).to_a.shuffle.first
      @no_microposts.times do |k|
        about_id = (1..@no_users).to_a.shuffle.first 
        content = Faker::Lorem.sentence
        content = content.slice(0,140)
        user.microposts.create( :content => content, :about_id => about_id )
      end
    end

  end
end
      
