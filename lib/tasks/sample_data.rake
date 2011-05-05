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
                    :sire_bloodline => "Red Star",
                    :dam_id => 2,
                    :dam_bloodline => "Peppy",
                    :markings => "White socks",
                    :photo_file_name => "horse_1.jpg",
                    :photo_content_type => "image/jpg",
                    :photo_file_size => 4661,
                    :owner => "Owner One")

    @no_horses = 25
    @no_horses.times do |n|
      name = Faker::Name.name
      breed = %w{Argentinian Criollo Thoroughbred Arabian}.shuffle.first
      color = %w{Black Brown White Bay Grey}.shuffle.first
      photo_no = (n+2)%11
      photo_file_name = "horse_#{photo_no}.jpg"
      gender = %w{Stallion Mare Gelding}.shuffle.first 
      breeder = (1..10).to_a.shuffle.first
      sire = (1..30).to_a.shuffle.first
      sire_bloodline = %w{Pepy Ranger Gasper Vamos Galapagos}.shuffle.first
      dam =  (1..30).to_a.shuffle.first
      dam_bloodline = %w{Ruby Angel Madame Bluedevil}.shuffle.first
      markings = %w{socks white-spots black-spots grey-patch}.shuffle.first
      owner = Faker::Name.name
      Horse.create!(:name => name,
                    :breed => breed,
                    :color => color,
                    :gender => gender,
                    :photo_file_name => photo_file_name,
                    :photo_content_type => "image/jpeg",
                    :breeder_id => breeder,
                    :sire_id => sire,
                    :sire_bloodline => sire_bloodline,
                    :dam_id => dam,
                    :dam_bloodline => dam_bloodline,
                    :markings => markings,
                    :owner => owner)

    end
     
    Player.create!( :name => "Ignacio Figuera",
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

    @no_users = 10
    @no_users.times do |n| 
      name = Faker::Name.first_name
      email = Faker::Internet.email
      user = User.create!(:name => name, :email => email )

      @no_microposts = (1..5).to_a.shuffle.first
      @no_microposts.times do |k|
        player_id = (1..@no_players).to_a.shuffle.first
        content = Faker::Lorem.sentence
        content = content.slice(0,140)
        user.microposts.create( :content => content, :player_id => player_id)
      end

      @no_comments = (1..3).to_a.shuffle.first
      @no_comments.times do |k|
        horse_id = (1..@no_horses).to_a.shuffle.first
        content = Faker::Lorem.sentence
        content = content.slice(0,140)
        user.comments.create( :content => content, :horse_id => horse_id)
      end
    end


  end
end
      
