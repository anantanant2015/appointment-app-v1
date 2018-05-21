defmodule Appointment.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :kind, :string, null: false

      timestamps()
    end

    create unique_index(:roles, [:kind])
  end
end
