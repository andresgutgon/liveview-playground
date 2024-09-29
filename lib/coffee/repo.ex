defmodule Coffee.Repo do
  use Ecto.Repo,
    otp_app: :coffee,
    adapter: Ecto.Adapters.Postgres
end
