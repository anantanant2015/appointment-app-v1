defmodule Appointment.PageController do
  use Appointment.Web, :controller

  alias Appointment.User
  alias Appointment.Repo


  @base "http://localhost:4000"

  def index(conn, _params) do
    render conn, "index.html", [base: @base]
  end

  def home(conn, _params) do
    render conn, "home.html", [base: @base]
  end
end
