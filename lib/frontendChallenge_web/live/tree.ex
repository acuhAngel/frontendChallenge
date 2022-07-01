defmodule FrontendChallengeWeb.Tree do
  use Surface.LiveView

  alias FrontendChallengeWeb.Components.RootManagers

  def render(assigns) do
    ~F"""
    <style>
      .employee{
      display: felx;
      align-items: center;
      justify-content: space-around;
      background-color: gray;
      margin: 10px;
      }
      .manager{
      display: felx;
      align-items: center;
      justify-content: space-between;
      border: solid;
      margin-left: 10px;
      margin-bottom: 30px;
      background: orange;
      }
      summary{
      background-color: red;
      }

      .box{
      margin: 10px
      }
    </style>

    <div class="employee">
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
