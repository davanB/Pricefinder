defmodule PricefinderWeb.CheapestOfferController do
  use PricefinderWeb, :controller

  alias Pricefinder.Validation.ParamValidator
  alias PricefinderWeb.ErrorHelpers
  alias Pricefinder.CheapestOffer

  def index(conn, params) do
    params
    |> ParamValidator.validate()
    |> case do
      %{valid?: true} = cs ->
        CheapestOffer.get_cheapest_offer(cs.changes)
        |> case do
          result when result == %{} ->
            render(conn, "no_data.json")

          %{airline: airline, amount: amount} ->
            render(conn, "cheapest_offer.json", airline: airline, amount: amount)
        end

      cs ->
        conn
        |> put_status(400)
        |> put_view(PricefinderWeb.ErrorView)
        |> render("400.json", message: ErrorHelpers.format_errors(cs))
    end
  end
end
