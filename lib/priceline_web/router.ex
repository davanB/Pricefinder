defmodule PricefinderWeb.Router do
  use PricefinderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PricefinderWeb do
    pipe_through :api

    get "/findCheapestOffer", CheapestOfferController, :index
  end
end
