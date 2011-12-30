class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @title = "Products"
  	@products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
    @title = @product.name
  end
  
  def new
    @title = "New product"
    @product = AmazonApi.get_reviewable_product
  end
  
  def create
    @title = "New product"
    @product = Product.new(params[:product])
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product,
              :notice => 'Product was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @title = "Edit product"
    @product = Product.find(params[:id])
  end
  
  def update
    @title = "Edit product"
    @product = Product.find(params[:id])
   
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product,
                      :notice => 'Product was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
end
