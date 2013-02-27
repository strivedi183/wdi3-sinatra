require 'pry'
require 'yahoofinance'
require 'sinatra'
require 'sinatra/reloader' if development?

get "/stock" do
  if params[:stock_symbol].nil?
    @stock_symbol = 'AAPL'
  else
    @stock_symbol = params[:stock_symbol]
  end
  begin
    @share_price = YahooFinance::get_quotes(YahooFinance::StandardQuote, @stock_symbol)[@stock_symbol].lastTrade
  rescue
    retry
  end
  erb :stock
end