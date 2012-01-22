class SearchController < ApplicationController

  def index
  	@query = params[:q] || ""
    terms = clean_query(@query)
    facets = {}
    [:game, :franchise, :developer, :merchant, :product_type].each do |f|
      p = f.to_s.pluralize.to_sym
      facets[f] = params[p].split(',') if params[p]
    end
    @products = Product.search(terms, 
          :populate => true, 
          :page => params[:page], 
          :per_page => 40, 
          :include => [:merchant, :images, :figures],
          :with => facets)
    @facets = @products.facets
    #Search.create(:query => terms, :ip_address => request.remote_ip, :num_results => @products.size)
  rescue Riddle::ConnectionError
    # flash.now[:notice] = "RAWR"
    @products = nil
  end
  
end
