defmodule Pricefinder.ResponseParser do
  def parse_response(airline, xpath, response) do
    response
    |> SweetXml.xpath(xpath)
    |> maybe_get_min_price()
    |> format_response(airline)
  end

  defp maybe_get_min_price([]) do
    :no_price_error
  end

  defp maybe_get_min_price(prices) do
    prices
    |> Enum.map(&List.to_string/1)
    |> Enum.map(&Float.parse/1)
    |> Enum.map(fn {amount, _} -> amount end)
    |> Enum.min()
  end

  defp format_response(:no_price_error = error, _airline), do: error
  defp format_response(amount, airline), do: %{airline: airline, amount: amount}
end
