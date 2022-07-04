defmodule FrontendChallengeWeb.Tree do
  use Surface.LiveView

  alias FrontendChallengeWeb.Components.RootManagers

  def render(assigns) do
    ~F"""
    <style>
    button{
      background-color: #D6FFB7;
      color: #080357;
    }
    .container{
      height: auto;
      width: auto;
      background-color: #F5FF90 ;
      padding: 10px;
    }

      .employee{
      display: felx;
      align-items: center;
      justify-content: space-around;
      background-color: #FF9F1C;
      margin: 10px;
      padding: 10px;
      }
      .manager{
      display: felx;
      align-items: center;
      justify-content: space-between;
      border: solid;
      padding:10px;
      margin-left: 10px;
      margin-bottom: 30px;
      background: #FFC15E;
      }
      summary{
      background-color: red;
      }

      .box{
      margin: 10px
      }
    </style>

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
