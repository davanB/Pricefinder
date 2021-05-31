defmodule Pricefinder.CheapestOffer do
  alias Pricefinder.Airlines.{BritishAirways, AirFranceKLM}

  @airlines [AirFranceKLM, BritishAirways]
  @task_supervisor OfferRetrieverSupervisor

  def get_cheapest_offer(params) do
    @airlines
    |> Enum.map(fn airline ->
      Task.Supervisor.async_nolink(
        @task_supervisor,
        __MODULE__,
        :get_cheapest_offer_for_airline,
        [airline, params]
      )
    end)
    |> Enum.map(fn task ->
      (Task.yield(task) ||
        Task.shutdown(task))
        |> case do
          {:ok, :client_error} ->
            :error

          {:ok, :no_price_error} ->
            :error

          {:ok, response} ->
            response

          _error ->
            :error
        end
    end)
    |> Enum.filter(fn result -> result != :error end)
    |> Enum.reduce(%{}, fn offer, cheapest_offer ->
      lower_offer(cheapest_offer, offer)
    end)
  end

  def get_cheapest_offer_for_airline(airline, params) do
    params
    |> airline.get_prices()
    |> parse_response(airline)
  end

  defp parse_response(:error, _airline) do
    :client_error
  end

  defp parse_response(response, airline) do
    airline.parse_response(response)
  end

  defp lower_offer(%{amount: amount_1} = offer_1, %{amount: amount_2}) when amount_1 <= amount_2,
    do: offer_1

  defp lower_offer(_offer_1, offer_2), do: offer_2
end
