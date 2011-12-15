class Api::ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_key
  
  def create
    render_json_message false
  end
  
  private
  
  def validate_key
    raise unless params[:key] == SETTINGS[:api_key]
  rescue
    render_json_message true, "Invalid key."
  end
  
  def render_json_message(error, message=nil)
    render :content_type => :json, :text => {:error => error, :message => message}.to_json
  end
end
