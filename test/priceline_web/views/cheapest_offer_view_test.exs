defmodule PricelineWeb.CheapestOfferViewTest do
  use ExUnit.Case

  alias PricelineWeb.CheapestOfferView

  test "can render cheapest_offer.json" do
    json = CheapestOfferView.render("cheapest_offer.json", %{airline: :BA, amount: 10})

    assert json == %{
             data: %{
               cheapestOffer: %{
                 amount: 10,
                 airline: :BA
               }
             }
           }
  end

  test "can redner no_data.json" do
    json = CheapestOfferView.render("no_data.json")

    assert json == %{
             data: "No price data available"
           }
  end
end
