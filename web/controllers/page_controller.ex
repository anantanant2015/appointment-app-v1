defmodule Appointment.PageController do
  use Appointment.Web, :controller

  alias Appointment.{User, Repo, Appointment}

  # plug :load_resource, model: User

  # plug Guardian.Plug.EnsureAuthenticated, handler: Appointment.PageController, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler

  

  def index(conn, _params) do
    render conn, "home.html"
  end

  def home(conn, _params) do
    render conn, "home.html"
  end
end
