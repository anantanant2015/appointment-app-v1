defmodule Appointment.PageView do
  use Appointment.Web, :view
  # def render("user.json", %{user: user}) do
  #   %{id: user.id, name: user.name, email: user.email, role: user.role}
  # end

  def validate(conn) do
    Map.has_key?(conn, :assign) &&
      Map.has_key?(conn.assign, :user) &&
        conn.assigns.user.kind in ["admin"]
  end
end
