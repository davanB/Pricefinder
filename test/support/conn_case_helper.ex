defmodule PricefinderWeb.ConnCaseHelper do
  def render_json(view, template, assigns \\ %{}) do
    template
    |> view.render(assigns)
    |> format_json()
  end

  defp format_json(data) do
    data
    |> Jason.encode!()
    |> Jason.decode!()
  end
end
