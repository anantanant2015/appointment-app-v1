defmodule Appointment.LoginView do
    use Appointment.Web, :view
    alias Appointment.User    

  def validate(conn) do
    Map.has_key?(conn, :assign) &&
      Map.has_key?(conn.assign, :user) &&
        conn.assigns.user.kind in ["admin"]
  end
end