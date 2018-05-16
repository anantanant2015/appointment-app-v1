defmodule Appointment.UserController do
    use Appointment.Web, :controller
  
    def index(conn, _params) do
      render conn, "index.html"
    end
  end