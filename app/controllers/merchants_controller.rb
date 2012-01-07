class MerchantsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @merchants = Merchant.all
  end
  
  def show
    @merchant = Merchant.find(params[:id])
    @title = @merchant.name
  end
  
  def new
    @merchant = Merchant.new
  end
  
  def create
    @merchant = Merchant.new(params[:merchant])
    
    respond_to do |format|
      if @merchant.save
        format.html { redirect_to(@merchant,
              :notice => 'Merchant was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def update
    @merchant = Merchant.find(params[:id])
   
    respond_to do |format|
      if @merchant.update_attributes(params[:merchant])
        format.html { redirect_to(@merchant,
                      :notice => 'Merchant was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
