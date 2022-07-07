defmodule FrontendChallengeWeb.Components.Employee do
  use Surface.Component

  prop(charge, :string)
  prop(i, :integer)
  prop(salary, :integer)

  def render(assigns) do
    ~F"""
    <div class="employee">
      <div>
        +{@charge}-{@i}
      </div>
      <div>
        ${@salary}
      </div>
      <button :on-click={"del", target: "#tree"} value={@i}>
        delete
      </button>
    </div>
    """
  end
end
