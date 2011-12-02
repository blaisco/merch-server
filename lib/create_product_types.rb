require 'ancestry'

module Seeds
  class CreateProductTypes
    def self.run
      # Create product types
      root = TreeNode.create! :name => 'Product Types'
        apparel = root.children.create :name => 'T-Shirts and Apparel'
          apparel.children.create :name => 'Unisex Shirts'
          apparel.children.create :name => 'Women\'s Shirts'
          apparel.children.create :name => 'Hoodies & Fleece'
          apparel.children.create :name => 'Jewelry'
          apparel.children.create :name => 'Hats & Ties'
          apparel.children.create :name => 'Kids Shirts & Onesies'
          apparel.children.create :name => 'Golf and Work Shirts'
          apparel.children.create :name => 'Miscellaneous (patches)'
        toys = root.children.create :name => 'Toys'
          toys.children.create :name => 'Plush'
        gadgets = root.children.create :name => 'Gadgets'
          gadgets.children.create :name => 'Cell Phone Goodies'
        home = root.children.create :name => 'Home & Office'
          home.children.create :name => 'Office Supplies'
          home.children.create :name => 'Gear'
          home.children.create :name => 'Mugs & Glasses'
          home.children.create :name => 'Posters'
          home.children.create :name => 'Stickers & Emblems'
    end
  end
end
