defmodule Appointment.LoginController do
    use Appointment.Web, :controller

    alias Appointment.{User, Repo, Auth}

    @base "http://localhost:4000"

    def new(conn, _params) do
        changeset = User.changeset(%User{}, _params)
        render conn, "login.html", [base: @base, changeset: changeset]
    end

    def create(conn, session_params) do
        case Auth.login(conn, session_params, Repo) do
            {:ok, user} ->
                conn
                # |> put_session(:current_user, user.id)
                # |> Auth.guardian_sign_in(user)
                |> Plug.Conn.assign(:current_user, user)
                |> put_flash(:info, "Logged in")
                |> redirect(to: "/home")
            
            :error ->
                conn
                |> put_flash(:error, "Incorrect email or password!")
                |> redirect(to: "/login")

        end
    end

    def delete(conn, _params) do
        conn
        # |> delete_session(:current_user)
        # |> Auth.guardian_sign_out
        |> put_flash(:info, "Logged out!")
        |> redirect(to: "/login")
    end
end