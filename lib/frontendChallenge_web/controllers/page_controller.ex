defmodule FrontendChallengeWeb.PageController do
  use FrontendChallengeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
