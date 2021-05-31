defmodule PricefinderWeb.ErrorViewTest do
  use PricefinderWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 400.json" do
    json = render(PricefinderWeb.ErrorView, "400.json", message: "Missing parameters")

    assert json == %{
             error: %{
               message: "Missing parameters",
               expected_parameters: %{
                 origin: %{
                   type: :string,
                   description: "The origin airport code"
                 },
                 destination: %{
                   type: :string,
                   description: "The destination airport code"
                 },
                 departureDate: %{
                   type: :date,
                   description: "The departure date from the origin"
                 }
               }
             }
           }
  end

  test "renders 404.json" do
    assert render(PricefinderWeb.ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(PricefinderWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
