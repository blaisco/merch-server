class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def clean_query(query)
    query.downcase.strip.squeeze(" ")
  end
end
