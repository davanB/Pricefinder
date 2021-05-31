defmodule Pricefinder.ResponseParsers.AirFranceKLM do
  import SweetXml
  alias Pricefinder.ResponseParser

  @airline_code :AFKL

  def parse_response(response) do
    xpath = ~x"//ns2:TotalPrice/ns2:TotalAmount/text()"l
    ResponseParser.parse_response(@airline_code, xpath, response)
  end
end
