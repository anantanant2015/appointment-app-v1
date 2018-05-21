defmodule Appointment.AdminController do
  use Appointment.Web, :controller

  alias Appointment.User
  alias Appointment.Repo

  plug :load_resource, model: Appointment.User
  # plug Appointment.EnsureAdmin, [handler: Appointment.AdminController, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler]

  @base "http://localhost:4000"

  def show(conn, _params) do
    users = Repo.all(User)

    # if user |> can?(:show, users) do
    #   render conn, "admin.html", [base: @base, users: users, changeset: changeset]
    # else
      render conn, "admin.html", base: @base
    # end
    # render conn, "admin.html", base: @base, users: users
  end

  # def edit(conn, %{"id" => id}) do
  #   user = Repo.get!(User, id)
  #   changeset = Role.changeset(user)

  #   if user |> can?(:edit, Role) do
  #     render conn, "admin_edit.html", [base: @base, user: user, changeset: changeset]
  #   else
  #     render conn, "admin.html", base: @base
  #   end
  # end

  # def update(conn,%{} = user) do
  #   user = Repo.get!(User, user["id"])
  #   changeset = User.changeset(User, user)

  #   case Repo.update(changeset) do
  #     {:ok, role} ->
  #       conn
  #       |> put_flash(:info, "User updated successfully.")
  #       |> redirect(to: role_path(conn, :show, user))
  #     {:error, changeset} ->
  #       render(conn, "admin_edit.html", user: user, changeset: changeset)
  #   end
  # end
end
