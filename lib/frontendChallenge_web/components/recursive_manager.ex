defmodule FrontendChallengeWeb.Components.RecursiveManager do
  use Surface.LiveComponent

  alias FrontendChallenge.DBmanager
  alias FrontendChallengeWeb.Components.{Employee, MenuManager}

  prop(padre, :integer)
  data employees, :list, default: []

  def render(assigns) do
    ~F"""
    <div class="manager">
    manager {@padre}
    <button :on-click="load" value={@padre}>
      Load
    </button>
    <br>
    <button :on-click={"add_man", target: "#tree"} value={@padre}>
      manager
    </button>
    <button :on-click={"add_dev", target: "#tree"} value={@padre}>
      developer
    </button>
    <button :on-click={"add_qa", target: "#tree"} value={@padre}>
      tester
    </button>

    {#for emp <- @employees}
      {#if emp.charge == :manager}
      {render(%{__context__: %{}, employees: DBmanager.getEmployees(emp.id), padre: emp.id, id: emp.id, myself: ""})}
      {#else}
      {emp.parent_id}<Employee charge={emp.charge} i={emp.id} salary={emp.salary} id={emp.id} />
      {/if}
    {#else}
      NODATA reload or add one employee
    {/for}
    </div>
    """
  end

  def handle_event("load", %{"value" => id}, socket) do
    IO.puts("LOADING employees")

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getEmployees(id)
      )
    }
  end

  def handle_event("add_dev", %{"value" => id}, socket) do
    DBmanager.add(id, :manager, 300)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getEmployees(id)
      )
    }
  end
end
