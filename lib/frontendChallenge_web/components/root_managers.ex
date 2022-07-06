defmodule FrontendChallengeWeb.Components.RootManagers do
  use Surface.LiveView

  alias FrontendChallenge.DBmanager
  alias FrontendChallengeWeb.Components.{Employee, MenuManager, RecursiveManager}

  data employees, :list, default: []

  def render(assigns) do
    ~F"""
    <div>
      {#for employee <- @employees}
        {#if employee.parent_id |> is_nil}
          <div class="manager">
            <MenuManager this_id={employee.id}>
              {employee.charge} {employee.id} &nbsp;&nbsp;&nbsp;&nbsp; $ 300 <br>
            </MenuManager>
            {#for emp <- DBmanager.getEmployees(employee.id)}
              {#if emp.charge != :manager}
                <div>
                  <Employee charge={emp.charge} i={emp.id} salary={emp.salary} />
                </div>
              {#elseif emp.charge == :manager}
                <div>
                  <RecursiveManager padre={emp.id} id={emp.id} />
                </div>
              {/if}
            {/for}
            TOTAL {employee.salary_team}
          </div>
        {/if}
      {#else}
        No data
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
