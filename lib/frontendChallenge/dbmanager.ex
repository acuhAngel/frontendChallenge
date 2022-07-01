defmodule FrontendChallenge.DBmanager do
  import Ecto.Query
  import Ecto.Changeset
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
    end
  end

  def del(id) do
    Repo.delete_all(from e in Employees, where: e.id == ^id)
    Repo.delete_all(from e in Employees, where: e.parent_id == ^id)
  end

  def getManagers() do
    Repo.all(
      from e in Employees,
        select: [e.charge, e.salary, e.id],
        where: e.charge == :manager and is_nil(e.parent_id)
    )
  end

  def getEmployees(id) do
    IO.puts("hijos de")
    IO.inspect(id)

    Repo.all(
      from e in Employees,
        where: e.parent_id == ^id
    )
  end

  def getTotal(id) do
    s =
      Repo.all(from e in Employees, select: sum(e.salary), where: e.parent_id == ^id)
      |> List.first()

    s2 = Repo.all(from e in Employees, select: sum(e.salary), where: e.id == ^id) |> List.first()

    if s == nil do
      s2
    else
      s + s2
    end
  end

  def getAll() do
    Repo.all(from(e in Employees))
  end
end
