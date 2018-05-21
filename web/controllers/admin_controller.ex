defmodule Appointment.AdminController do
  use Appointment.Web, :controller

  alias Appointment.{User, Role}
  alias Appointment.Repo

  plug :load_resource, model: Appointment.User, only: :show
  # plug Appointment.EnsureAdmin, [handler: Appointment.AdminController, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler]

  @base "http://localhost:4000"

  def show_all(conn, _params) do
    users = Repo.all(User)
            |> Repo.preload(:role)
    # if user |> can?(:show, users) do
    #   render conn, "admin.html", [base: @base, users: users, changeset: changeset]
    # else
      # render conn, "admin.html", base: @base
    # end
    render conn, "admin_all.html", base: @base, users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
            |> Repo.preload(:role)
    render conn, "admin.html", base: @base, user: user
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
            |> Repo.preload(:role)
    changeset = User.changeset(user, %{})
    role = Repo.all(Role)

    # if user |> can?(:edit, Role) do
    render conn, "admin_edit.html", [base: @base, user: user, changeset: changeset, role: role]
    # else
    #   render conn, "admin.html", base: @base
    # end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.register_changeset(user, user_params, String.to_integer(user_params["role_id"])) |> IO.inspect
    
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
            |> put_flash(:info, "User updated successfully.")
            # |> IO.inspect
            |> redirect(to: "/admin")
            
      {:error, changeset} ->
        render(conn, "admin_edit.html", base: @base)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: "/admin")
  end
end
