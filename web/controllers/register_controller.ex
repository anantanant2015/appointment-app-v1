defmodule Appointment.RegisterController do
    use Appointment.Web, :controller
    
    alias Appointment.{User, Role, Repo}

    @base "http://localhost:4000"    

    def new(conn, _params) do
        changeset = User.changeset(%User{}, _params)
        role = Repo.all(Role)
        render conn, "register.html", [base: @base, changeset: changeset, role: role]
    end

    def register(conn, %{"user" => user_params}) do
        role = Repo.get(Role, String.to_integer(user_params["role"]))
        
        # changeset = Ecto.build_assoc(role, :users, name: user_params["name"], email: user_params["email"], )
        # require IEx
        # IEx.pry
        changeset = User.register_changeset(%User{}, user_params, role.id)
        case Repo.insert(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "#{user.name} created!")
                |> redirect(to: admin_path(conn, :show))

            {:error, changeset} ->
                role = Repo.all(Role)
                render conn, "register.html", [base: @base, changeset: changeset, role: role]
        end
    end
end