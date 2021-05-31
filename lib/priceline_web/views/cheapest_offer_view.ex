defmodule PricelineWeb.CheapestOfferView do
  use PricelineWeb, :view

  def render("cheapest_offer.json", %{airline: airline, amount: amount}) do
    %{
      data: %{
        cheapestOffer: %{
          amount: amount,
          airline: airline
        }
      }
    }
  end

  def render("no_data.json", _assigns) do
    %{
      data: "No price data available"
    }
  end
end
