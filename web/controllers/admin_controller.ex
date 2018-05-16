defmodule Appointment.AdminController do
  use Appointment.Web, :controller

  alias Appointment.User
  alias Appointment.Repo


  @base "http://localhost:4000"

  def admin(conn, _params) do
    users = Repo.all(User)
    
    render conn, "admin.html", base: @base, users: users
  end
end
