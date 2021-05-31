defmodule Pricefinder.CheapestOfferTest do
  use ExUnit.Case
  import Mox

  alias Pricefinder.CheapestOffer
  alias Pricefinder.Clients.{MockAirFranceKLM, MockBritishAirways}
  alias Pricefinder.Airlines.{AirFranceKLM, BritishAirways}

  @british_airways BritishAirways
  @air_france_klm AirFranceKLM

  setup :verify_on_exit!

  setup do
    params = %{
      origin: "MUC",
      destination: "LHR",
      departureDate: Date.from_iso8601!("2019-07-17")
    }

    [params: params]
  end

  test "can get and parse airfare response", %{params: params} do
    MockAirFranceKLM
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(@air_france_klm)
    end)

    MockBritishAirways
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(@british_airways)
    end)

    assert %{airline: :BA, amount: 132.38} ==
             CheapestOffer.get_cheapest_offer_for_airline(@british_airways, params)

    assert %{airline: :AFKL, amount: 199.29} ==
             CheapestOffer.get_cheapest_offer_for_airline(@air_france_klm, params)
  end
end
