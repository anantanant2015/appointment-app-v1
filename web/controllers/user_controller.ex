defmodule Appointment.UserController do
    use Appointment.Web, :controller

  alias Appointment.{User, Role}
  alias Appointment.Repo

  # plug :load_resource, model: Appointment.User#, only: :show
  # plug Appointment.EnsureAdmin, [handler: Appointment.AdminController, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler]

  @base "http://localhost:4000"

  def index(conn, _params) do
    users = Repo.all(User)
            |> Repo.preload(:role)
    
    render conn, "index.html", base: @base, users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
            |> Repo.preload(:role)
    render conn, "user.html", base: @base, user: user
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
            |> Repo.preload(:role)
    changeset = User.changeset(user, %{})
    role = Repo.all(Role)

    render conn, "user_edit.html", [base: @base, user: user, changeset: changeset, role: role]
    
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.register_changeset(user, user_params, String.to_integer(user_params["role_id"]))
    
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
            |> put_flash(:info, "User updated successfully.")
            |> redirect(to: "/admin")
            
      {:error, changeset} ->
        render(conn, "user_edit.html", base: @base)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: "/users")
  end
  end