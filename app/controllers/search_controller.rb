class SearchController < ApplicationController

  def index
  	@query = params[:q] || ""
    terms = clean_query(@query)
    @products = Product.search(terms, :populate => true, :page => params[:page], :per_page => 40)
    @facets = Product.facets
    #Search.create(:query => terms, :ip_address => request.remote_ip, :num_results => @products.size)
  rescue Riddle::ConnectionError
    # flash.now[:notice] = "RAWR"
    @products = nil
  end
  
end
