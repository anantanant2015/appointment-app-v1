defmodule Appointment.Repo.Migrations.CreateState do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string

      timestamps()
    end

  end
end
