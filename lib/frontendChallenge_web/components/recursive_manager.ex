defmodule FrontendChallengeWeb.Components.RecursiveManager do
  use Surface.LiveComponent

  alias FrontendChallenge.DBmanager
  alias FrontendChallengeWeb.Components.{Employee, MenuManager}

  prop(padre, :integer)
  data employees, :list, default: []

  def render(assigns) do
    ~F"""
    <div class="manager">
      <div>
        manager {@padre}
        <button :on-click="load" value={@padre}>
          Load
        </button>
        <br>
        <button :on-click={"del", target: "#tree"} value={@id}>
          delete
        </button>
        <button :on-click={"add_man", target: "#tree"} value={@padre}>
          manager
        </button>
        <button :on-click={"add_dev", target: "#tree"} value={@padre}>
          developer
        </button>
        <button :on-click={"add_qa", target: "#tree"} value={@padre}>
          tester
        </button>
      </div>
      <div>
        {#for emp <- @employees}
          <div>
            {#if emp.charge == :manager}
              <div>
                {render(%{
                  __context__: %{},
                  employees: DBmanager.getEmployees(emp.id),
                  padre: emp.id,
                  id: emp.id,
                  myself: ""
                })}
              </div>
            {#else}
              <Employee charge={emp.charge} i={emp.id} salary={emp.salary} id={emp.id} />
            {/if}
          </div>
        {/for}
        TOTAL {DBmanager.getTotal(@padre)}
      </div>
      <br>
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
