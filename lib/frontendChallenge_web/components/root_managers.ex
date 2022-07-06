defmodule FrontendChallengeWeb.Components.RootManagers do
  use Surface.LiveView

  alias FrontendChallenge.DBmanager
  alias FrontendChallengeWeb.Components.{Employee, MenuManager, RecursiveManager}

  data employees, :list, default: []

  def render(assigns) do
    ~F"""
    <div>
      {#for employee <- @employees}
        <div>
          {#if employee.charge == :manager}
            <div class="manager">
              <MenuManager this_id={employee.id} charge={employee.charge}>
                <div>
                {render(%{
                  __context__: %{},
                  employees: DBmanager.getEmployees(employee.id),
                })}
                <div>TOTAL ${employee.salary_team}</div>
                </div>
              </MenuManager>
            </div>

          {#elseif employee.charge != :manager}
            <Employee charge={employee.charge} i={employee.id} salary={employee.salary}/>
          {/if}
        </div>
      {#else}

      {/for}
    </div>
    """
  end

  def handle_event("load", _, socket) do
    IO.puts("LOADING managers")

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getAll()
      )
    }
  end

  def handle_event("del", %{"value" => id}, socket) do
    DBmanager.del(String.to_integer(id))

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getAll()
      )
    }
  end

  def handle_event("add_dev", %{"value" => id}, socket) do
    DBmanager.add(id, :developer, 1000)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getAll()
      )
    }
  end

  def handle_event("add_qa", %{"value" => id}, socket) do
    DBmanager.add(id, :qa_tester, 500)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getAll()
      )
    }
  end

  def handle_event("add_man", %{"value" => id}, socket) do
    DBmanager.add(id, :manager, 300)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getAll()
      )
    }
  end

  def handle_event("root_man", _, socket) do
    DBmanager.add(nil, :manager, 300)

    {
      :noreply,
      assign(
        socket,
        employees: DBmanager.getAll()
      )
    }
  end
end
