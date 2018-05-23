defmodule Appointment.RegisterController do
    use Appointment.Web, :controller
    
    alias Appointment.{User, Role, Repo}

        

    def new(conn, _params) do
        changeset = User.changeset(%User{}, _params)
        role = Repo.all(Role)
        render conn, "register.html", [changeset: changeset, role: role]
    end

    def register(conn, %{"user" => user_params}) do
        role = Repo.get(Role, String.to_integer(user_params["role"]))
        
        changeset = User.register_changeset(%User{}, user_params, role.id)
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "#{user.name} created!")
                |> redirect(to: "/users/#{user.id}")

            {:error, changeset} ->
                role = Repo.all(Role)
                render conn, "register.html", [changeset: changeset, role: role]
        end
    end
end