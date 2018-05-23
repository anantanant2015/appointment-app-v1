defmodule Appointment.AppointmentController do
  use Appointment.Web, :controller

  alias Appointment.{Appointment, User, State}

  plug :authorize_resource, model: Appointment, only: [:index, :edit, :update, :delete]

  def index(conn, _params) do
    appointments = Repo.all(Appointment)
            |> Repo.preload(:user)
            |> Repo.preload(:state)

    render(conn, "index.html", appointments: appointments)
  end

  def new(conn, %{"user_id" => user_id}) do
    user = Repo.get(User, user_id)
            |> Repo.preload(:role)
    
    states = Repo.all(State)
    
    changeset = Appointment.changeset_new(%Appointment{})

    render(conn, "new.html", [changeset: changeset, user: user, states: states])
  end

  def create(conn, %{"appointment" => appointment_params}) do
    changeset = Appointment.changeset_new(%Appointment{}, appointment_params)
    states = Repo.all(State)
    user = Repo.get(User, 5)
            |> Repo.preload(:role)

    case Repo.insert(changeset) do
      {:ok, _appointment} ->
        conn
        |> put_flash(:info, "Appointment created successfully.")
        |> redirect(to: appointment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", [changeset: changeset, user: user, states: states])
    end
  end

  

  def show(conn, %{"id" => id}) do
    appointment = Repo.get!(Appointment, id)
            |> Repo.preload(:user)
            |> Repo.preload(:state)
    render(conn, "show.html", appointment: appointment)
  end

  def edit(conn, %{"id" => id}) do
    appointment = Repo.get!(Appointment, id)
            |> Repo.preload(:user)
            |> Repo.preload(:state)

    states = Repo.all(State)
    
    changeset = Appointment.changeset(appointment)
    render(conn, "edit.html", appointment: appointment, user: appointment.user, changeset: changeset, states: states)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Repo.get!(Appointment, id)
    changeset = Appointment.changeset_update(appointment, appointment_params)

    case Repo.update(changeset) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment updated successfully.")
        |> redirect(to: appointment_path(conn, :show, appointment))
      {:error, changeset} ->
        render(conn, "edit.html", appointment: appointment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Repo.get!(Appointment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(appointment)

    conn
    |> put_flash(:info, "Appointment deleted successfully.")
    |> redirect(to: appointment_path(conn, :index))
  end
end
