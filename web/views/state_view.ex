defmodule Appointment.StateView do
  use Appointment.Web, :view

  def validate(conn) do
    Map.has_key?(conn, :assign) &&
      Map.has_key?(conn.assign, :user) &&
        conn.assigns.user.kind in ["admin"]
  end
end
