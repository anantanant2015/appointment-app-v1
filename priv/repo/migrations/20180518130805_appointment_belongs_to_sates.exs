defmodule Appointment.Repo.Migrations.AppointmentBelongsToSates do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :state_id, references(:states)
    end
  end
end
