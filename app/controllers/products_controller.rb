class ProductsController < ApplicationController
  caches_page :show, :expires_in => 12.hours, :race_condition_ttl => 30.seconds
  before_filter :authenticate_user!, :except => [:show]
  
  def show
    @product = Product.unscoped.includes(:images, :variations, :figures).find(params[:id])
    @primary_image = @product.images.find_by_id(params[:image_id]) || @product.primary_image
  end
  
  def new
    @product = AmazonApi.get_reviewable_product
  end
  
  def create
    @product = Product.new(params[:product])
    
    if @product.save
      redirect_to(@product,
            :notice => 'Product was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
    @product = Product.unscoped.find(params[:id])
    @product.typifications.build if @product.typifications.size == 0
  end
  
  def update
    @product = Product.unscoped.find(params[:id])
   
    if @product.update_attributes(params[:product])
      expire_page :action => "show", :id => params[:id]
      if params[:next].blank?
        redirect_to(@product, :notice => 'Product was successfully updated.')
      else
        product = Product.pending.first
        if product
          redirect_to(edit_product_path(product), :notice => 'Product was successfully updated.')
        else
          redirect_to(admin_path, :notice => 'Product was successfully updated.')
        end
      end
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @product = Product.unscoped.find(params[:id])
    @product.destroy
    redirect_to products_path
  end
end
