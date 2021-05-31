defmodule Pricefinder.ResponseParsers.BritishAirways do
  import SweetXml
  alias Pricefinder.ResponseParser
  @airline_code :BA

  def parse_response(response) do
    xpath = ~x"//TotalPrice/SimpleCurrencyPrice/text()"l
    ResponseParser.parse_response(@airline_code, xpath, response)
  end
end
