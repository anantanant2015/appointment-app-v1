defmodule Appointment.Repo.Migrations.AppointmentBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :user_id, references(:users)
    end
  end
end
