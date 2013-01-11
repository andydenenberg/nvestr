class StocksController < ApplicationController
  before_filter :authenticate_user!
  # GET /stocks
  # GET /stocks.json
  def index
    @view = params[:view] ||= 'Performance'
    @port = params[:portfolio] ||= 'Family Favorites'
    @stocks = Stock.portfolio(@port) # where(:portfolio => params[:portfolio])
    
    puts params.inspect 
    
     if params[:mobile] == 'true'
       if params[:type_of_action] == 'overall'
         render :partial => 'overall_action.mobile', :layout => false
       else
         render :partial => 'todays_action.mobile', :layout => false
       end
     end
      
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stock = Stock.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/new
  # GET /stocks/new.json
  def new
    @stock = Stock.new
    @stock.comments.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stock }
    end
  end

  # GET /stocks/1/edit
  def edit
    @stock = Stock.find(params[:id])
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(params[:stock])

    if @stock.save
      redirect_to stocks_path
    else
      render action: "new"
    end
    
#    respond_to do |format|
#      if @stock.save
#        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
#        format.json { render json: @stock, status: :created, location: @stock }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @stock.errors, status: :unprocessable_entity }
#      end
#    end

  end

  # PUT /stocks/1
  # PUT /stocks/1.json
  def update
    @stock = Stock.find(params[:id])

    respond_to do |format|
      if @stock.update_attributes(params[:stock])
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end
end
