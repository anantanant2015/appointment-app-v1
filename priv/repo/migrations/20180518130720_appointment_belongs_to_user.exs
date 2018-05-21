defmodule Appointment.Repo.Migrations.AppointmentBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
