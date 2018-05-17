defmodule Appointment.EnsureAdmin do
    alias Appointment.Auth

    def init(opts) do
        opts
    end

    def call(conn, _opts) do
        user = Auth.current_user(conn)

        if user && user.role == "admin" do
            conn
        else
            conn
            |> Plug.Conn.halt
            |> Phoenix.Controller.put_flash(:error, "User permission violated!")
            |> Phoenix.Controller.redirect(to: "/home")
        end
    end
end
