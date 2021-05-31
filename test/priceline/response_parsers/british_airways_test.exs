defmodule Pricefinder.ResponseParsers.BritishAirwaysTest do
  use ExUnit.Case

  alias Pricefinder.ResponseParsers.BritishAirways

  @british_airways :BA

  test "can parse response" do
    result =
      @british_airways
      |> TestUtils.read_mock_response()
      |> BritishAirways.parse_response()

    assert result == %{airline: @british_airways, amount: 132.38}
  end

  test "doesnt blow up if no flight data" do
    result =
      :no_data
      |> TestUtils.read_mock_response()
      |> BritishAirways.parse_response()

    assert result == :no_price_error
  end
end
