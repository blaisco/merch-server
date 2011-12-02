class JunctionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    
  end
  
  def show
    
  end
  
  def new
    @title = "Add Junctions"
  end
  
  def create
    stats = { :new => 0, :existing => 0, :failed => 0, :total => 0 }
    api = AmazonApi.first
    asins = params[:asins].split(',')
    asins.each do |asin|
      stats[:total] += 1
      asin = AmazonApi.get_parent_asin(asin.strip)
      junction = api.junctions.find_or_initialize_by_uid(asin)
      if junction
        junction.new_record? ? stats[:new] += 1 : stats[:existing] += 1
      end
      stats[:failed] += 1 unless junction.save
    end
    
    msg = "New: " + stats[:new].to_s + "/" + stats[:total].to_s 
    msg += " | Existing: " + stats[:existing].to_s + "/" + stats[:total].to_s 
    msg += " | Failed: " + stats[:failed].to_s + "/" + stats[:total].to_s 
    redirect_to(new_amazon_api_junction_path,
          :notice => msg)
  end
  
  def edit
    
  end
  
  def update
    
  end
end
