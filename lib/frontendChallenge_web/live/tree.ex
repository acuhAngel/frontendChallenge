defmodule FrontendChallengeWeb.Tree do
  use Surface.LiveView

  alias FrontendChallengeWeb.Components.RootManagers

  def render(assigns) do
    ~F"""
    <div class="container">
      <button :on-click={"root_man", target: "#tree"}>
        add root manager
      </button>
      <button :on-click={"load", target: "#tree"}>
        load
      </button>
      <RootManagers id="tree" />
    </div>
    """
  end
end
