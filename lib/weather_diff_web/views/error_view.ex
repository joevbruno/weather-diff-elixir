defmodule WeatherDiffWeb.ErrorView do
  use WeatherDiffWeb, :view

  def render("404.json-api", _assigns) do
    "Page not found"
  end

  def render("500.json-api", _assigns) do
    "Internal server error"
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json-api", assigns
  end
end
