# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Appointment.Repo.insert!(%Appointment.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias Appointment.{Repo, State, Role}
state_1 = %{"name" => "open"}

case %State{} |> State.changeset(state_1) |> Repo.insert do
    {:ok, struct}       -> IO.inspect struct
    {:error, changeset} -> IO.inspect changeset
end

state_2 = %{"name" => "closed"}

case %State{} |> State.changeset(state_2) |> Repo.insert do
    {:ok, struct}       -> IO.inspect struct
    {:error, changeset} -> IO.inspect changeset
end

state_3 = %{"name" => "cancelled"}

case %State{} |> State.changeset(state_3) |> Repo.insert do
    {:ok, struct}       -> IO.inspect struct
    {:error, changeset} -> IO.inspect changeset
end

role_1 = %{"kind" => "user"}

case %Role{} |> Role.changeset(role_1) |> Repo.insert do
    {:ok, struct}       -> IO.inspect struct
    {:error, changeset} -> IO.inspect changeset
end

role_2 = %{"kind" => "admin"}

case %Role{} |> Role.changeset(role_2) |> Repo.insert do
    {:ok, struct}       -> IO.inspect struct
    {:error, changeset} -> IO.inspect changeset
end
