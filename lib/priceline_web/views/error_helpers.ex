defmodule PricefinderWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  def format_errors(%Ecto.Changeset{} = cs) do
    cs |> errors_on() |> format_errors()
  end

  def format_errors(error_map) when is_map(error_map) do
    Enum.flat_map(error_map, fn
      {_key, errors} when is_map(errors) -> format_errors(errors)
      {key, errors} -> ["#{key}: #{Enum.join(errors, ", ")}"]
    end)
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate "is invalid" in the "errors" domain
    #     dgettext("errors", "is invalid")
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    # This requires us to call the Gettext module passing our gettext
    # backend as first argument.
    #
    # Note we use the "errors" domain, which means translations
    # should be written to the errors.po file. The :count option is
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(PricefinderWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(PricefinderWeb.Gettext, "errors", msg, opts)
    end
  end
end
