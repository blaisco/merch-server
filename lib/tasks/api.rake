namespace :api do
  namespace :product do
    task :create => :environment do
      # product with inventory
      #json_str = "{\"description\": \"For fifteen years, Valve Corporation has defined the cutting edge of video games. Now, Valve joins with Dark Horse to bring three critically acclaimed, fan-favorite series to print, with a hardcover collection of comics from the worlds of Left 4 Dead, Team Fortress, and Portal. With over 200-pages of story, Valve Presents: The Sacrifice and Other Steam-Powered Stories is a must-read for fans looking to further explore the games they love, or comics readers interested in dipping their toes into new mythos! This strictly limited collector\\u0092s edition of the official Portal 2 Game Guide features additional art, a hardcover binding and two bookmarks.\\r\\nPublisher: Future Press\\r\\nISBN: 9783869930381\\r\\nPages: 384\\r\\nSize: 8 1/4\\\" x 11 1/2\\\"\", \"merchant_url\": \"http://store.valvesoftware.com/\", \"url\": \"http://store.valvesoftware.com/product.php?i=P0909\", \"image_urls\": [\"http://store.valvesoftware.com/product_images/main_images/P0909main.png\"], \"summary\": \"This strictly limited collector\\u0092s edition of the official Portal 2 Game Guide features additional art, a hardcover binding and two bookmarks.\", \"inventory\": [{\"color\": null, \"amount_saved\": \"500\", \"currency\": \"USD\", \"in_stock\": true, \"price\": \"2499\", \"size\": null}], \"images\": [{\"url\": \"http://store.valvesoftware.com/product_images/main_images/P0909main.png\", \"path\": \"full/e7082274593a43382d1d1424ec4ea9b540569e06.jpg\", \"checksum\": \"f3b00dc98d85a335be4aa95a41d37520\"}], \"name\": \"Portal 2 Collectors Edition Guide\"}"
      # out of stock product
      json_str = "{\"name\": \"Portal 2 Portal Intro Study\", \"url\": \"http://store.valvesoftware.com/product.php?i=P2221\", \"image_urls\": [\"http://store.valvesoftware.com/product_images/main_images/P2221main.png\"], \"inventory\": [{\"color\": null, \"price\": null, \"currency\": \"USD\", \"in_stock\": false, \"sale_price\": null, \"size\": null}], \"merchant_url\": \"http://store.valvesoftware.com/\", \"images\": [{\"url\": \"http://store.valvesoftware.com/product_images/main_images/P2221main.png\", \"path\": \"full/2bf1e498ca3b634b7c119c22756cf516bb1a5aea.jpg\", \"checksum\": \"863dd860f81c755395fa30f1fbf457f8\"}], \"description\": \"Portal 2 -  Lithograph - Portal Intro Study by Jeremy Bennett. \\\"This study attempts to capture the scale of a new portion of Aperture while alluding to the amount of damage that time has inflicted on the facility. You find yourself alone having to navigate through the crumbling overgrown remains in the vague hope that GLaDOS will allow you to escape.\\\"  Lithograph measures 36\\\" x 24\\\" and is printed on 100# stock McCoy Silk Cover, Spot Gloss UV.  Regular edition lithograph - not signed or numbered.\"}"
      
      object = JSON.parse(json_str)
      ProductJob.perform(object)

      puts "====== Product JSON ======"
      puts "#{object.to_json}"
      puts "============================"
    end
  end
end
