defmodule FrontendChallengeWeb.Components.Total do
  @moduledoc """
  a component to share the total amount of the team by manager.
  """

  use Surface.Component
  prop total, :integer, default: 0
  def render(assigns) do
    ~F"""
    <section class="total">
      <div>
        TOTAL
      </div>
      <div>
      ${@total}
      </div>
    </section>
<div class="division"> </div>
    """
  end
end
