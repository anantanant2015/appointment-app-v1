defmodule Appointment.Auth do
    alias Appointment.{Encryption, User}

    def login(conn, params, repo) do
        user = repo.get_by(User, email: String.downcase(params["user"]["email"]))
        case authenticate(user, params["user"]["password"]) do
            true -> {:ok, user}
            _ -> :error
        end
    end

    defp authenticate(user, password) do
        case user do
            nil -> false
            _ -> Encryption.validate_password(password, user.hashed_password)
        end
    end

    def current_user(conn) do
        Plug.Conn.get_session(conn, :current_user)
        # token = Appointment.Guardian.Plug.current_token(conn)
        # if token do
        #     {:ok, resource, claims} = Appointment.Guardian.resource_from_token(token)
        #     resource
        # else
        #     nil
        # end
        # id = Plug.Conn.get_session(conn, :current_user)
        # if id, do: Appointment.Repo.get(User, id)
    end

    def logged_in?(conn), do: !!current_user(conn)

    def guardian_sign_in(conn, resource) do
        Appointment.Guardian.Plug.sign_in(conn, resource)
    end

    def guardian_sign_out(conn) do
        Appointment.Guardian.Plug.sign_out(conn)
    end
end

defmodule Appointment.AuthErrorHandler do
    import Plug.Conn
    
    alias Plug.Conn
    alias Appointment.User
    alias Phoenix.Controller
    @base "http://localhost:4000" 

    

    def auth_error(conn, {type, reason}, _opts) do
      body = Poison.encode!(%{message: to_string(type)})
      changeset = User.changeset(%User{}, %{})

    #   send_resp(conn, 401, body)
    conn
        |> Plug.Conn.halt
        |> Controller.put_flash(:error, to_string(type))
        |> Controller.redirect(to: "/login")
    end
end

defmodule Appointment.Plug.CurrentUser do
  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)
    Plug.Conn.assign(conn, :current_user, current_user)
  end
end