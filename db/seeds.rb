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
  apparel = root.children.create :name => 'T-Shirts and Apparel', :rank => 1
    apparel.children.create :name => 'Unisex Shirts', :rank => 1
    apparel.children.create :name => 'Women\'s Shirts', :rank => 2
    apparel.children.create :name => 'Hoodies & Fleece', :rank => 3
    apparel.children.create :name => 'Jewelry', :rank => 4
    apparel.children.create :name => 'Hats & Ties', :rank => 5
    apparel.children.create :name => 'Kids Shirts & Onesies', :rank => 6
    apparel.children.create :name => 'Golf and Work Shirts', :rank => 7
    apparel.children.create :name => 'Miscellaneous', :rank => 8
  toys = root.children.create :name => 'Toys', :rank => 2
    toys.children.create :name => 'Plush', :rank => 1
  gadgets = root.children.create :name => 'Gadgets', :rank => 3
    gadgets.children.create :name => 'Cell Phone Goodies', :rank => 1
  home = root.children.create :name => 'Home & Office', :rank => 4
    home.children.create :name => 'Office Supplies', :rank => 1
    home.children.create :name => 'Gear', :rank => 2
    home.children.create :name => 'Mugs & Glasses', :rank => 3
    home.children.create :name => 'Posters', :rank => 4
    home.children.create :name => 'Stickers & Emblems', :rank => 5



