class SearchesController < ApplicationController
  def index
  	@query = params[:q]
    if @query
      query_on = clean_query(@query)
      @search = Search.create(:query => query_on, :ip_address => request.remote_ip, :num_results => 0)
      # Do search, fill in number of results in statement above
    else
      # Redirect back
    end
  end
  
  def new
    @search = Search.new
  end
end
