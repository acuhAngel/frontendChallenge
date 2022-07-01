defmodule FrontendChallenge.Repo do
  use Ecto.Repo,
    otp_app: :frontendChallenge,
    adapter: Ecto.Adapters.Postgres
end
