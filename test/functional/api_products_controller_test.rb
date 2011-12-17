require 'test_helper'

class ApiProductsControllerTest < ActionController::TestCase
  JSON_EXAMPLE = "{\"name\": \"Portal 2 Collectors Edition Guide\", \"url\": \"http://store.valvesoftware.com/product.php?i=P0909\", \"image_urls\": [\"http://store.valvesoftware.com/product_images/main_images/P0909main.png\"], \"summary\": \"This strictly limited collector\\u0092s edition of the official Portal 2 Game Guide features additional art, a hardcover binding and two bookmarks.\", \"inventory\": [{\"color\": null, \"sale_price\": \"$24.99\", \"price\": \"$29.99\", \"in_stock\": true, \"size\": null}], \"description\": \"This strictly limited collector\\u0092s edition of the official Portal 2 Game Guide features additional art, a hardcover binding and two bookmarks.\\r\\nPublisher: Future Press\\r\\nISBN: 9783869930381\\r\\nPages: 384\\r\\nSize: 8 1/4\\\" x 11 1/2\\\"\"}"

  setup do
    @controller = Api::ProductsController.new
  end

  context "create" do
    context "with valid params" do
      setup do
        post :create, :key => Settings.api_key, :product => JSON_EXAMPLE
      end
    
      should "respond without json error" do
        assert JSON.parse(@response.body)["error"].to_s == "false"
      end
    end
    
    context "with invalid product" do
      setup do
        post :create, :key => Settings.api_key, :product => "RAWR"
      end

      should "respond with json error" do
        assert JSON.parse(@response.body)["error"].to_s == "true"
      end
    end

    context "with invalid key" do
      setup do
        post :create, :key => "RAWR", :product => JSON_EXAMPLE
      end

      should "respond with json error" do
        assert JSON.parse(@response.body)["error"].to_s == "true"
      end
    end
  end
end
