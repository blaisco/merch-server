class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    @title = "Products"
  	@products = Product.all
  end
  
  def show
    @product = Product.unscoped.find(params[:id])
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
    @product = Product.unscoped.find(params[:id])
    @product.typifications.build if @product.typifications.size == 0
  end
  
  def update
    @title = "Edit product"
    @product = Product.unscoped.find(params[:id])
   
    respond_to do |format|
      if @product.update_attributes(params[:product])
        if params[:next].blank?
          format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        else
          product = Product.pending.first
          if product
            format.html { redirect_to(edit_product_path(product), :notice => 'Product was successfully updated.') }
          else
            format.html { redirect_to(admin_path, :notice => 'Product was successfully updated.') }
          end
        end
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @product = Product.unscoped.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
end
