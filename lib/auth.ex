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

    

    def auth_error(conn, {type, reason}, _opts) do
      body = Poison.encode!(%{message: to_string(type)})
      changeset = User.changeset(%User{}, %{})

    #   send_resp(conn, 401, body)
    conn
        |> Plug.Conn.halt
        |> Controller.put_flash(:error, to_string(type))
        |> Controller.redirect(to: "/login")
    end

    def handle_unauthorized(conn) do
        conn
        |> Controller.put_flash(:error, "You can't access that page!")
        |> Controller.redirect(to: "/home")
        |> Plug.Conn.halt
    end

    def handle_not_found(conn) do
        conn
        |> Controller.put_flash(:error, "Handle not found!")
        |> Controller.redirect(to: "/home")
        |> Plug.Conn.halt
    end
end

defmodule Appointment.Plug.CurrentUser do
  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)
    Plug.Conn.assign(conn, :current_user, current_user)
  end
end

defmodule Appointment.Plug.SessionUpdate do

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = (Map.get(conn, :private) |> Map.get(:plug_session) |> Map.get("user_id"))
    if user_id do
    user =  Appointment.Repo.get(Appointment.User, user_id)
            |> Appointment.Repo.preload(:role)
    conn
    |> Plug.Conn.put_session(:user, user)
    |> Plug.Conn.assign(:user, user)
    else
        Appointment.AuthErrorHandler.handle_unauthorized(conn)
    end
  end
end

defmodule Appointment.Plug.SessionLoad do

  def init(opts), do: opts

  def call(conn, _opts) do
    user = Plug.Conn.get_session(conn, :user)

    conn    
    |> Plug.Conn.assign(:user, user)
  end
end