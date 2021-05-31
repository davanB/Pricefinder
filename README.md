# Pricefinder

Are you looking for the cheapest flight between KLM and British Airways? Then Pricefinder is the web app for you!. This simple JSON API will compare and return the cheaper flight.

## How to run

```zsh
# To start your system
_build/prod/rel/pricefinder/bin/pricefinder start

# From the source code
cd pricefinder
mix phx.server
```

## Example Usage

http://localhost:4000/findCheapestOffer?origin=BER&destination=LHR&departureDate=2019-07-17

Requirements:
- elixir 1.10.4-otp-23
- erlang 23.0.2
