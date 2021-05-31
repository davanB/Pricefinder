defmodule Pricefinder.Clients.Client do
  @callback get_prices(String.t(), String.t(), Date.t()) :: {:ok, any()} | {:error, any()}
end
