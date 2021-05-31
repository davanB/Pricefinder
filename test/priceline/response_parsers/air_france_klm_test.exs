defmodule Pricefinder.ResponseParsers.AirFranceKLMTest do
  use ExUnit.Case

  alias Pricefinder.ResponseParsers.AirFranceKLM

  @air_france_klm :AFKL

  test "can parse response" do
    result =
      @air_france_klm
      |> TestUtils.read_mock_response()
      |> AirFranceKLM.parse_response()

    assert result == %{airline: @air_france_klm, amount: 199.29}
  end

  test "doesnt blow up if no flight data" do
    result =
      :no_data
      |> TestUtils.read_mock_response()
      |> AirFranceKLM.parse_response()

    assert result == :no_price_error
  end
end
