defmodule Pricefinder.Airlines.BritishAirways do
  alias Pricefinder.Airline
  @behaviour Airline

  def get_prices(params) do
    Airline.get_prices(:BA, params)
  end

  def parse_response(response) do
    Airline.parse_response(Pricefinder.ResponseParsers.BritishAirways, response)
  end
end
