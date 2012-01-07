class ProductTypesController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @root = ProductType.roots.first
  end
  
  def show
    @category = ProductType.find(params[:id])
    redirect_to product_types_path if @category.is_root?
  end
  
  def new
    @category = ProductType.new
  end
  
  def create
    @category = ProductType.new(params[:product_type])
    
    respond_to do |format|
      if @category.save
        format.html { redirect_to(@category,
              :notice => 'Category was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @category = ProductType.find(params[:id])
  end
  
  def update
    @category = ProductType.find(params[:id])
   
    respond_to do |format|
      if @category.update_attributes(params[:product_type])
        format.html { redirect_to(@category,
                      :notice => 'Category was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
end
