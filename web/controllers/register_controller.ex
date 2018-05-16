defmodule Appointment.RegisterController do
    use Appointment.Web, :controller
    
    alias Appointment.User
    alias Appointment.Repo

    @base "http://localhost:4000"    

    def new(conn, _params) do
        changeset = User.changeset(%User{}, _params)
        render conn, "register.html", [base: @base, changeset: changeset]
    end

    def register(conn, %{"user" => user_params}) do
        changeset = User.changeset(%User{}, user_params)
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "#{user.name} created!")
                |> redirect(to: admin_path(conn, :admin))

            {:error, changeset} ->
                render conn, "register.html", [base: @base, changeset: changeset]
        end
    end
end