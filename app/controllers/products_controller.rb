class ProductsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
  	@query = params[:q] || ""
    terms = clean_query(@query)
    @products = Product.search terms, :populate => true
    @facets = Product.facets
    #Search.create(:query => terms, :ip_address => request.remote_ip, :num_results => @products.size)
  rescue Riddle::ConnectionError
    # flash.now[:notice] = "RAWR"
    @products = nil
  end
  
  def show
    @product = Product.unscoped.find(params[:id])
    @image = @product.images.find_by_id(params[:image_id]) || @product.primary_image
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
