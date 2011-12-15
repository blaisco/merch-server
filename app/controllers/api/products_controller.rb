require 'json'

class Api::ProductsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :validate_key
  
  def create
    object = JSON.parse(params[:product])
    ProductJob.perform(object)
    
    # I was having lots of issues getting Resque to process jobs correctly.
    # So I'm keeping the job mechanism (maybe I can get Resque to work later) 
    # but I'm removing Resque queueing for now.
    #~ Resque.enqueue(ProductJob, object)
    
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
