defmodule FrontendChallenge.DBmanager do
  import Ecto.Query
  import Ecto.Changeset
  alias Ecto.Changeset
  alias FrontendChallenge.{Repo, Employees}

  def add(id, charge, salary) do
    if is_nil(id) do
      Repo.insert(%Employees{charge: charge, salary: salary, salary_team: salary})
    else
      Repo.insert(%Employees{
        charge: charge,
        parent_id: String.to_integer(id),
        salary: salary,
        salary_team: salary
      })

      update_parents_salary(String.to_integer(id), salary, "plus")
    end
  end

  def update_parents_salary(parent_id, child_salary, "plus") do
    parent_id |> IO.inspect()
    parent = Repo.get(Employees, parent_id)
    children_salary = getTotal(parent_id)
    update = Changeset.change(parent, salary_team: children_salary + child_salary)
    Repo.update(update)

    if parent.parent_id != nil do
      update_parents_salary(parent.parent_id, parent.salary_team, "plus")
    end
  end

  def update_parents_salary(parent_id, child_salary, "minus") do
    IO.puts("update salary minus")
    parent_id |> IO.inspect()
    parent = Repo.get(Employees, parent_id) |> IO.inspect()
    update = Ecto.Changeset.change(parent, salary_team: parent.salary_team - child_salary)
    Repo.update(update)
    parent = Repo.get(Employees, parent_id)

    if parent.parent_id != nil do
      update_parents_salary(parent.parent_id, parent.salary_team, "minus")
    end
  end

  def del(id) do
    emp_to_del = Repo.get(Employees, String.to_integer(id)) |> IO.inspect()

    if emp_to_del.parent_id != nil do
      Repo.delete(emp_to_del)
      update_parents_salary(emp_to_del.parent_id, emp_to_del.salary_team, "minus")
    else
      IO.puts("si se puede")
      Repo.delete_all(from e in Employees, where: e.id == ^id)
      # borrar hijos
    end
  end

  def getManagers() do
    Repo.all(
      from e in Employees,
        select: [e.charge, e.salary, e.id],
        where: e.charge == :manager and is_nil(e.parent_id)
    )
  end

  def getEmployees(id) do
    IO.puts("loading hijos de")
    IO.inspect(id)

    Repo.all(
      from e in Employees,
        where: e.parent_id == ^id
    )
  end

  def getTotal(id) do
    # s =
    #   Repo.all(from e in Employees, select: sum(e.salary_team), where: e.parent_id == ^id)
    #   |> List.first()

    s2 =
      Repo.all(from e in Employees, select: sum(e.salary_team), where: e.id == ^id)
      |> List.first()

    # if s == nil do
    #   s2
    # else
    #   s + s2
    # end
  end

  def getAll() do
    Repo.all(from(e in Employees))
  end
end
