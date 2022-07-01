defmodule FrontendChallengeWeb.Components.Employee do
  use Surface.Component

  alias FrontendChallenge.DBmanager

  prop(charge, :string)
  prop(i, :integer)
  prop(salary, :integer)
  slot default

  def render(assigns) do
    ~F"""
    <div class="employee">
      {@charge}{@i} &nbsp;&nbsp;&nbsp;&nbsp; ${@salary} &nbsp;&nbsp;&nbsp;&nbsp;
      <button :on-click={"del", target: "#tree"} value={@i}>
        delete
      </button>
    </div>
    """
  end
end
