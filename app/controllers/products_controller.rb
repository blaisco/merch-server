class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  caches_action :show, 
    :expires_in => 12.hours, 
    :race_condition_ttl => 30.seconds, 
    # Can't do layout => false because of how we're handling javascript includes
    # :layout => false, 
    :cache_path => Proc.new { |c| c.params.delete_if { |k,v| !["image_id","id"].include?(k) } }
    
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
      # Expire our action cache for our product + any image variants
      expire_fragment(Regexp.new("products/#{@product.slug}.*"))
      
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
    if @product.destroy
      expire_page :action => "show", :id => params[:id]
    end
    redirect_to products_path
  end
end
