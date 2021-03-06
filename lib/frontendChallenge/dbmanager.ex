defmodule FrontendChallenge.DBmanager do
  import Ecto.Query
  alias Ecto.Changeset
  alias FrontendChallenge.{Repo, Employees}

  def add(id, charge, salary) do
    if is_nil(id) do
      IO.puts("agregando root manager id #{id}")
      insert(charge, nil, salary)
    else
      IO.puts("agregando empleado id #{id}")
      insert(charge, String.to_integer(id), salary)
      IO.puts("actualizando parent id #{id} salary_team")
      update_parents_salary(String.to_integer(id))
    end
  end

  def insert(charge, parent_id, salary) do
    Repo.insert(%Employees{
      charge: charge,
      parent_id: parent_id,
      salary: salary,
      salary_team: salary
    })
  end

  def update_parents_salary(parent_id) do
    parent = Repo.get(Employees, parent_id)
    children_salary = getTotal(parent_id)
    update = Changeset.change(parent, salary_team: children_salary)
    Repo.update(update)

    if parent.parent_id != nil do
      update_parents_salary(parent.parent_id)
    end
  end

  def del(id) do
    IO.puts("borrando empleado #{id}")
    emp_to_del = Repo.get(Employees, id)
    Repo.delete(emp_to_del)

    if not is_nil(emp_to_del.parent_id) do
      if not is_nil(Repo.get(Employees, emp_to_del.parent_id)) do
        update_parents_salary(emp_to_del.parent_id)
      end
    end

    getEmployees(id)
    |> Enum.each(fn child ->
      del(child.id)
    end)
  end

  def getEmployees(id) do
    Repo.all(from e in Employees, where: e.parent_id == ^id, order_by: e.id)
  end

  def getTotal(id) do
    IO.puts("get employee:#{id}  salary:")

    s =
      Repo.all(from e in Employees, select: sum(e.salary), where: e.id == ^id)
      |> List.first()

    IO.puts("get employee:#{id} children salary")

    s2 =
      Repo.all(from e in Employees, select: sum(e.salary_team), where: e.parent_id == ^id)
      |> List.first()

    if is_nil(s2) do
      s
    else
      s + s2
    end
  end

  def getAll() do
    Repo.all(
      from e in Employees, where: e.charge == :manager and is_nil(e.parent_id), order_by: e.id
    )
  end
end
