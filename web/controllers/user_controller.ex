defmodule Appointment.UserController do
    use Appointment.Web, :controller

  alias Appointment.{User, Role}
  alias Appointment.Repo

  plug :load_and_authorize_resource, model: User, only: :show
  
  plug :authorize_resource, model: User, only: [:show, :index, :edit, :update, :delete]

  

  def index(conn, params) do
    users = Repo.all(User)
            |> Repo.preload(:role)
    
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
            |> Repo.preload(:role)
    render conn, "user.html", user: user
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
            |> Repo.preload(:role)
    changeset = User.changeset(user, %{})
    role = Repo.all(Role)

    render conn, "user_edit.html", [user: user, changeset: changeset, role: role]
    
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.register_changeset(user, user_params, String.to_integer(user_params["role_id"]))
    
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
            |> put_flash(:info, "User updated successfully.")
            |> redirect(to: "/users/#{id}")
            
      {:error, changeset} ->
        render(conn, "user_edit.html")
    end
  end

  def delete(conn, %{"user_id" => user_id}) do
    user = Repo.get!(User, user_id)

    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: "/users")
  end
  end