defmodule FrontendChallengeWeb.Components.RecursiveManager do
  use Surface.LiveComponent

  alias FrontendChallenge.DBmanager
  alias FrontendChallengeWeb.Components.{Employee, MenuManager}

  prop(padre, :integer)
  data employees, :list, default: []

  def render(assigns) do
    ~F"""
    <div class="manager">
    <MenuManager this_id={@padre}>  manager {@padre} &nbsp;&nbsp;&nbsp;&nbsp; $300 <button :on-click="load" value={@padre}>
    Load
    </button> </MenuManager>

      <div>
        {#for emp <- @employees}
          <div>
            {#if emp.charge == :manager}
              <br>
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
              <Employee charge={emp.charge} i={emp.id} salary={emp.salary}/>
            {/if}
          </div>
        {/for}
      </div>
      <br>
      total {DBmanager.getTotal(@padre)}
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
    IO.puts("AGREGANDO DEVELOPER ")
    DBmanager.add(id, :developer, 1000)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getEmployees(id)
      )
    }
  end

  def handle_event("add_qa", %{"value" => id}, socket) do
    IO.puts("AGREGANDO qa ")
    DBmanager.add(id, :qa_tester, 500)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getEmployees(id)
      )
    }
  end

  def handle_event("add_man", %{"value" => id}, socket) do
    IO.puts("AGREGANDO manager ")
    DBmanager.add(id, :manager, 300)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getEmployees(id)
      )
    }
  end

  def handle_event("del", %{"value" => id}, socket) do
    IO.puts("borrando elemento")
    DBmanager.del(id)
    IO.puts("obteniendo empleados")

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getEmployees(id)
      )
    }
  end
end
