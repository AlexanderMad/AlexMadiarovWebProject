class ProductsController < ApplicationController
  # http_basic_authenticate_with name: "a", password: "a", except: [:index, :show]

  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def cart
      @products = []

      products = cookies[:products_in_cart].split(" ").collect! { |n| n.to_i }

      products.each { |item|
        @product = Product.find_by id: item
        @products.push(@product)
      }
  end

  def add_to_cart
    if cookies.permanent[:products_in_cart].nil?
      cookies.permanent[:products_in_cart] = ''
    end

    @product = Product.find(params[:id])
    cookies.permanent[:products_in_cart] =  cookies.permanent[:products_in_cart] + " " + @product.id.to_s
    redirect_to products_path
  end

  def checkout
    unless cookies.permanent[:products_in_cart].nil?
      cookies.permanent[:products_in_cart] = ''
    end

    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
   
    redirect_to products_path
  end

  def create
    @product = Product.new(product_params)
 
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
 
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  private
    def product_params
      params.require(:product).permit(:title, :image, :price, :description)
    end
end
