defmodule FrontendChallenge.Repo.Migrations.NewTable do
  use Ecto.Migration

  def change do
    create table(:employees, primary_key: false) do
      add :id, :serial, primary_key: true
      add :parent_id, :integer
      add :charge, :string
      add :salary, :integer
      add :salary_team, :integer
    end
  end
end
