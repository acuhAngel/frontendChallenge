defmodule FrontendChallengeWeb.Components.RootManagers do
  use Surface.LiveView

  alias FrontendChallenge.DBmanager
  alias FrontendChallengeWeb.Components.{Total, Employee, MenuManager}

  data employees, :list, default: []

  def render(assigns) do
    ~F"""
    <div>
      {#for employee <- @employees}
        <div>
          {#if employee.charge == :manager}
            <div class="manager">
              <MenuManager this_id={employee.id}>
                <div class="box teamborder">
                  {render(%{
                    __context__: %{},
                    employees: DBmanager.getEmployees(employee.id)
                  })}
                  <Total total={employee.salary_team} />
                </div>
              </MenuManager>
            </div>
          {#elseif employee.charge != :manager}
            <div>
              <Employee charge={employee.charge} i={employee.id} salary={employee.salary} />
            </div>
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

  def handle_event("add", data, socket) do
    DBmanager.add(
      data["id"],
      data["charge"] |> String.to_atom(),
      data["salary"] |> String.to_integer()
    )

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
