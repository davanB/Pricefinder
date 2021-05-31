defmodule Pricefinder.Validation.ParamValidator do
  import Ecto.Changeset

  @schema %{
    origin: :string,
    destination: :string,
    departureDate: :date
  }

  def validate(attrs) do
    req_fields = Map.keys(@schema)

    attrs
    |> cast()
    |> validate_required(req_fields)
    |> validate_change(:departureDate, &validate_departure_date/2)
  end

  defp cast(attrs) do
    {%{}, @schema}
    |> cast(attrs, Map.keys(@schema))
  end

  defp validate_departure_date(:departureDate, date) do
    Date.utc_today()
    |> Date.compare(date)
    |> case do
      :gt ->
        [departureDate: "Departure date must be today or in the future"]

      _ ->
        []
    end
  end
end
