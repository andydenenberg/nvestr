class PortfoliosController < ApplicationController

    def create
      @portfolio = Portfolio.new(params[:portfolio])
      if @portfolio.save
        redirect_to stocks_path(:portfolio => @portfolio.name )
      else
        redirect_to stocks_path # need to add error handling in the future
      end
    end
  
end