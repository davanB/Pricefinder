defmodule Pricefinder.CheapestOfferControllerTest do
  use PricefinderWeb.ConnCase
  import Mox

  alias PricefinderWeb.CheapestOfferView
  alias PricefinderWeb.ErrorView
  alias Pricefinder.Validation.ParamValidator
  alias PricefinderWeb.ErrorHelpers
  alias Pricefinder.Clients.{MockAirFranceKLM, MockBritishAirways}

  setup :verify_on_exit!
  setup :set_mox_from_context

  @british_airways :BA
  @air_france_klm :AFKL

  test "index", %{conn: conn} do
    MockAirFranceKLM
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(@air_france_klm)
    end)

    MockBritishAirways
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(@british_airways)
    end)

    params = %{"departureDate" => "2222-01-01", "destination" => "LRH", "origin" => "MUC"}
    conn = get(conn, Routes.cheapest_offer_path(conn, :index, params))

    assert json_response(conn, 200) ==
             render_json(CheapestOfferView, "cheapest_offer.json", %{airline: "BA", amount: 132.38})
  end

  test "index with invalid params", %{conn: conn} do
    cs = ParamValidator.validate(%{})
    conn = get(conn, Routes.cheapest_offer_path(conn, :index))

    assert json_response(conn, 400) ==
             render_json(ErrorView, "400.json", message: ErrorHelpers.format_errors(cs))
  end

  test "index when only 1 price returned", %{conn: conn} do
    MockAirFranceKLM
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(@air_france_klm)
    end)

    MockBritishAirways
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(:no_data)
    end)

    params = %{"departureDate" => "2222-01-01", "destination" => "LRH", "origin" => "MUC"}
    conn = get(conn, Routes.cheapest_offer_path(conn, :index, params))

    assert json_response(conn, 200) ==
             render_json(CheapestOfferView, "cheapest_offer.json", %{airline: "AFKL", amount: 199.29})
  end

  test "index with no return data", %{conn: conn} do
    MockAirFranceKLM
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(:no_data)
    end)

    MockBritishAirways
    |> expect(:get_prices, fn _origin, _destination, _departureDate ->
      TestUtils.read_mock_response(:no_data)
    end)

    params = %{"departureDate" => "2222-01-01", "destination" => "LRH", "origin" => "MUC"}
    conn = get(conn, Routes.cheapest_offer_path(conn, :index, params))

    assert json_response(conn, 200) ==
             render_json(CheapestOfferView, "no_data.json")
  end
end
