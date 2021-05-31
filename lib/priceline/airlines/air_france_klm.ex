defmodule Pricefinder.Airlines.AirFranceKLM do
  @behaviour Pricefinder.Airline

  def get_prices(%{origin: origin, destination: destination, departureDate: departureDate}) do
    :AFKL
    |> get_client()
    |> apply(:get_prices, [origin, destination, departureDate])
  end

  def parse_response(response) do
    Pricefinder.ResponseParsers.AirFranceKLM.parse_response(response)
  end

  defp get_client(airline) do
    :pricefinder
    |> Application.get_env(:clients)
    |> Keyword.get(airline)
  end
end
