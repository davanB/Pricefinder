defmodule Pricefinder.Airline do
  @callback get_prices(map()) :: {:ok, any()} | {:error, any()}
  @callback parse_response(String.t()) :: map()

  def get_prices(airline, %{
        origin: origin,
        destination: destination,
        departureDate: departureDate
      }) do
    airline
    |> get_client()
    |> apply(:get_prices, [origin, destination, departureDate])
  end

  def parse_response(parser, response) do
    parser.parse_response(response)
  end

  defp get_client(airline) do
    :pricefinder
    |> Application.get_env(:clients)
    |> Keyword.get(airline)
  end
end
