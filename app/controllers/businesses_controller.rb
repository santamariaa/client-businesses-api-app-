class BusinessesController < ApplicationController
  def index
     @businesses = Business.all
  end

  def show
    # @business = Business.new(Unirest.get("http://localhost:3000/businesses/#{params[:id]}").body)

    @business = Business.find(params[:id])  
  end

  def new
  end

  def create
    @business = Unirest.post("http://localhost:3000/businesses", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ 
                          company_name: params[:company_name],
                          company_profession: params[:company_profession],
                          company_street_address: params[:company_street_address]}).body

    render :show

  end

  def edit
    @business = Unirest.get("http://localhost:3000/businesses/#{params[:id]}/edit").body
  end

  def update
    @business = Unirest.patch("http://localhost:3000/businesses", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ 
                          company_name: params[:company_name],
                          company_profession: params[:company_profession],
                          company_street_address: params[:company_street_address]}).body
    redirect_to :show
  end

  def destroy
    # message = Unirest.delete("http://localhost:3000/businesses/#{params[:id]}", headers:{ "Accept" => "application/json"}).body

    # flash[:message] = message["message"]
    # redirect_to "/businesses"

    @business = Business.find(params[:id])
    message = @business.destroy
    
    flash[:message] = message["message"]
    redirect_to "/businesses"
  end

end
