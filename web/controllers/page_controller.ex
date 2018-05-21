defmodule Appointment.PageController do
  use Appointment.Web, :controller

  alias Appointment.{User, Repo, Appointment}

  # plug :load_resource, model: User

  # plug Guardian.Plug.EnsureAuthenticated, handler: Appointment.PageController, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler

  @base "http://localhost:4000"

  def index(conn, _params) do
    render conn, "index.html", [base: @base]
  end

  def home(conn, _params) do
    # user_appointment = Repo.all(Appointment)
    render conn, "home.html", [base: @base]#, user_appointment: user_appointment]
  end
end
