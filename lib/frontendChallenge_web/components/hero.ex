defmodule FrontendChallengeWeb.Components.Hero do
  @moduledoc """
  A sample component generated by `mix surface.init`.
  """
  use Surface.Component

  import FrontendChallengeWeb.Gettext

  @doc "The name"
  prop(name, :string, default: "Guest")

  @doc "The subtitle"
  prop(subtitle, :string)

  @doc "The color"
  prop(color, :string, values!: ["danger", "info", "warning"])

  def render(assigns) do
    ~F"""
    <section class={"phx-hero", "alert-#{@color}": @color}>
      <h1>{gettext("Hi, %{name}!", name: @name)}</h1>
      <p>{@subtitle}</p>
    </section>
    """
  end
end
