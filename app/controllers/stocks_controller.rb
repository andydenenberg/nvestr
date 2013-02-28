class StocksController < ApplicationController
  before_filter :authenticate_user!
  # GET /stocks
  # GET /stocks.json
  
  def sell_shares
    stock = Stock.find(params[:stock_id])
    stock.sell_position(params[:shares])  
    PostLogger.info("Sell position - Now: #{stock.quantity} shares of #{stock.symbol} in #{stock.portfolio.user.name}'s - #{stock.portfolio.name} Portfolio")
          
    redirect_to stocks_path( :portfolio => params[:portfolio])    
  end
  
  def new_portfolio
    @portfolio = Portfolio.new :cash => 10000.00    
  end
  
  def lookup
    price = Quote.current_price(params[:symbol])
    render :text => price['LastTrade'].to_s  + '#&#' + price['Name'] + '#&#' + price['Change']  
  end

  def manage_list
#    @stocks = Stock.portfolio(params[:portfolio_view],params[:type_of_action]) # where(:portfolio => params[:portfolio])
    @stocks = Portfolio.where(:name => params[:portfolio_view], :user_id => current_user).first.rank_by_gain_loss(params[:type_of_action])    
    @port = params[:portfolio_view]
  end
  
  def index
        
        
    @error = params[:error]
    
    @view = params[:view] ||= 'Performance'
    
    @port = params[:portfolio] ||= Portfolio.where(:user_id => current_user).first.name if !Portfolio.where(:user_id => current_user).empty?
        
    @stocks = Portfolio.where(:name => @port, :user_id => current_user).first.rank_by_gain_loss(params[:type_of_action]) 

    @portfolio = Portfolio.new :cash => 100000.0

     if params[:type_of_action]
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
    @port = params[:portfolio_view]
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
    @port = params[:portfolio]
    
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.add_position(params[:stock])
    if @stock
      PostLogger.info("Add position - Now: #{@stock.quantity} shares of #{@stock.symbol} in #{@stock.portfolio.user.name}'s - #{@stock.portfolio.name} Portfolio")
      redirect_to stocks_path( :portfolio => @stock.portfolio.name )
    else
      @stock = Stock.new # added with controller tests and commented out the next line
#      @error = @stock.errors.full_messages
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
        PostLogger.info("Change position - Now: #{@stock.quantity} shares of #{@stock.symbol} in #{@stock.portfolio.user.name}'s - #{@stock.portfolio.name} Portfolio")

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
