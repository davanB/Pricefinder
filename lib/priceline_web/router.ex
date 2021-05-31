defmodule PricelineWeb.Router do
  use PricelineWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PricelineWeb do
    pipe_through :api

    get "/findCheapestOffer", CheapestOfferController, :index
  end
end
