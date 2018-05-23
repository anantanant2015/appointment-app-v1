defmodule Appointment.LoginController do
    use Appointment.Web, :controller

    alias Appointment.{User, Repo, Auth}

    

    def new(conn, params) do
        changeset = User.changeset(%User{}, params)
        render conn, "login.html", [changeset: changeset]
    end

    def create(conn, session_params) do
        case Auth.login(conn, session_params, Repo) do
            {:ok, user} ->
                conn
                |> put_session(:user_id, user.id)
                |> put_flash(:info, "Logged in")
                |> redirect(to: "/users/#{user.id}")
            
            :error ->
                conn
                |> put_flash(:error, "Incorrect email or password!")
                |> redirect(to: "/login")

        end
    end

    def delete(conn, _params) do
        conn
        |> delete_session(:user_id)
        |> clear_session
        |> put_session(:user_id, nil)
        |> put_flash(:info, "Logged out!")
        |> redirect(to: "/login")
    end
end