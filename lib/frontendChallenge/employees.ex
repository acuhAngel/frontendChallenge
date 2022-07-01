defmodule FrontendChallenge.Employees do
  use Ecto.Schema

  schema "employees" do
    field :parent_id, :integer
    field :charge, Ecto.Enum, values: [:manager, :developer, :qa_tester]
    field :salary, :integer
    field :salary_team, :integer
  end
end
