namespace :api do
  namespace :product do
    task :create => :environment do
      json_str = "{\"description\": \"For fifteen years, Valve Corporation has defined the cutting edge of video games. Now, Valve joins with Dark Horse to bring three critically acclaimed, fan-favorite series to print, with a hardcover collection of comics from the worlds of Left 4 Dead, Team Fortress, and Portal. With over 200-pages of story, Valve Presents: The Sacrifice and Other Steam-Powered Stories is a must-read for fans looking to further explore the games they love, or comics readers interested in dipping their toes into new mythos! This strictly limited collector\\u0092s edition of the official Portal 2 Game Guide features additional art, a hardcover binding and two bookmarks.\\r\\nPublisher: Future Press\\r\\nISBN: 9783869930381\\r\\nPages: 384\\r\\nSize: 8 1/4\\\" x 11 1/2\\\"\", \"merchant_url\": \"http://store.valvesoftware.com/\", \"url\": \"http://store.valvesoftware.com/product.php?i=P0909\", \"image_urls\": [\"http://store.valvesoftware.com/product_images/main_images/P0909main.png\"], \"summary\": \"This strictly limited collector\\u0092s edition of the official Portal 2 Game Guide features additional art, a hardcover binding and two bookmarks.\", \"inventory\": [{\"color\": null, \"amount_saved\": \"500\", \"currency\": \"USD\", \"in_stock\": true, \"price\": \"2499\", \"size\": null}], \"images\": [{\"url\": \"http://store.valvesoftware.com/product_images/main_images/P0909main.png\", \"path\": \"full/e7082274593a43382d1d1424ec4ea9b540569e06.jpg\", \"checksum\": \"f3b00dc98d85a335be4aa95a41d37520\"}], \"name\": \"Portal 2 Collectors Edition Guide\"}"
      
      object = JSON.parse(json_str)
      ProductJob.perform(object)

      puts "====== Product JSON ======"
      puts "#{object.to_json}"
      puts "============================"
    end
  end
end
