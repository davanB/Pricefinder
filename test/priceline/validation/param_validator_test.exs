defmodule Pricefinder.Validation.ParamValidatorTest do
  use ExUnit.Case

  alias Pricefinder.Validation.ParamValidator

  setup do
    [today: Date.utc_today()]
  end

  test "today passes validation", %{today: today} do
    today
    |> build_params()
    |> ParamValidator.validate()
    |> assert_valid_cs()
  end

  test "tomorrow passes validation", %{today: today} do
    today
    |> Date.add(1)
    |> build_params()
    |> ParamValidator.validate()
    |> assert_valid_cs()
  end

  test "yesterday fails validation", %{today: today} do
    today
    |> Date.add(-1)
    |> build_params()
    |> ParamValidator.validate()
    |> assert_cs_errors()
  end

  defp assert_valid_cs(%{valid?: true}), do: assert(true)
  defp assert_valid_cs(_), do: assert(false)

  defp assert_cs_errors(%{valid?: false, errors: [departureDate: _]}), do: assert(true)
  defp assert_cs_errors(_), do: assert(false)

  defp build_params(departure_date) do
    %{
      "origin" => "YYZ",
      "destination" => "YYZ",
      "departureDate" => Date.to_iso8601(departure_date)
    }
  end
end
