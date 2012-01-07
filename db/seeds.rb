# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(:email => 'test@videogamemerch.com', :password => 'test1234')

# Create product types
root = ProductType.create! :name => 'Merch', :rank => 1
  apparel = root.children.create :name => 'Apparel', :rank => 1
    apparel.children.create :name => 'Shirts', :rank => 1
    apparel.children.create :name => "Women's Shirts", :rank => 2
    apparel.children.create :name => 'Hoodies & Sweatshirts', :rank => 3
    apparel.children.create :name => 'Jackets', :rank => 4
    apparel.children.create :name => 'Onesies/Toddler Shirts', :rank => 5
    apparel.children.create :name => 'Misc. Apparel', :rank => 6
  access = root.children.create :name => 'Accessories', :rank => 2
    access.children.create :name => 'Neck Wraps/Scarves', :rank => 1
    access.children.create :name => 'Hats/Beanies', :rank => 2
    access.children.create :name => 'Bags', :rank => 3
    access.children.create :name => 'Lanyards', :rank => 4
    access.children.create :name => 'Pins', :rank => 5
    access.children.create :name => 'Keychains', :rank => 6
    access.children.create :name => 'Misc. Accessories', :rank => 7
  home = root.children.create :name => 'Home & Office', :rank => 4
    home.children.create :name => 'Mugs & Glasses', :rank => 1
    home.children.create :name => 'Coasters', :rank => 2
    home.children.create :name => 'Bottles/Canteens', :rank => 3
    home.children.create :name => 'iPhone/Kindle Cases', :rank => 4
    home.children.create :name => 'Mousepads', :rank => 5
    home.children.create :name => 'Headphones', :rank => 6
    home.children.create :name => 'Mice', :rank => 7
    home.children.create :name => 'Other Home & Office', :rank => 8
  toys = root.children.create :name => 'Toys', :rank => 3
    toys.children.create :name => 'Plush', :rank => 1
    toys.children.create :name => 'Figures', :rank => 2
    toys.children.create :name => 'Replicas', :rank => 3
    toys.children.create :name => 'Other Toys', :rank => 4
  art = root.children.create :name => 'Prints, Art, & Posters', :rank => 4
    art.children.create :name => 'Posters', :rank => 1
    art.children.create :name => 'Lithographs', :rank => 2
    art.children.create :name => 'Greeting Cards', :rank => 3
    art.children.create :name => 'Stickers', :rank => 4
    art.children.create :name => 'Calendars', :rank => 5
    art.children.create :name => 'Other Art', :rank => 6
  media = root.children.create :name => 'Books & Media', :rank => 5
    media.children.create :name => 'Novels', :rank => 1
    media.children.create :name => 'Audio Books', :rank => 2
    media.children.create :name => 'Art Books', :rank => 3
    media.children.create :name => 'Strategy Guides', :rank => 4
    media.children.create :name => 'Soundtracks', :rank => 5
    media.children.create :name => 'DVDs', :rank => 6
    media.children.create :name => 'Other Media', :rank => 7
