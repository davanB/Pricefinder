defmodule Pricefinder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PricelineWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pricefinder.PubSub},
      # Start the Endpoint (http/https)
      PricelineWeb.Endpoint,
      # Start a worker by calling: Pricefinder.Worker.start_link(arg)
      # {Pricefinder.Worker, arg}
      {Task.Supervisor, name: OfferRetrieverSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pricefinder.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PricelineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
