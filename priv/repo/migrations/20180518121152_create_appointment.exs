defmodule Appointment.Repo.Migrations.CreateAppointment do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :description, :string

      timestamps()
    end

  end
end
