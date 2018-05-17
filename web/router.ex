defmodule Appointment.Router do
  use Appointment.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
    plug Guardian.Plug.LoadResource, allow_blank: true, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Appointment do
    pipe_through :browser # Use the default browser stack

    get "/home", PageController, :home
    get "/register/new", RegisterController, :new
    post "/register", RegisterController, :register
    get "/login", LoginController, :new
    post "/login", LoginController, :create
    delete "/logout", LoginController, :delete
    get "/admin", AdminController, :admin
    get "/", PageController, :index    
  end

  # Other scopes may use custom stacks.
  # scope "/api", Appointment do
  #   pipe_through :api
  # end
end
