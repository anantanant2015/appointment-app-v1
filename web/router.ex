defmodule Appointment.Router do
  use Appointment.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
    plug Guardian.Plug.LoadResource, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
  end

  pipeline :require_login do
    plug Appointment.Plug.SessionUpdate, error_handler: Appointment.AuthErrorHandler
  end

  scope "/", Appointment do
  pipe_through [:browser]

  get "/home", PageController, :home
  get "/login", LoginController, :new
  post "/register", RegisterController, :register
  get "/register/new", RegisterController, :new
  post "/login", LoginController, :create
  
  get "/", PageController, :index    
  end

  scope "/", Appointment do
    pipe_through [:browser, :require_login]

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update
    delete "/users/:user_id", UserController, :delete

    delete "/logout", LoginController, :delete


    get "/appointments/new/:user_id", AppointmentController, :new
    get "/appointments/:id/edit", AppointmentController, :edit
    get "/roles", RoleController, :index

    resources "/roles", RoleController
    resources "/states", StateController
    resources "/appointments", AppointmentController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Appointment do
  #   pipe_through :api
  # end
end
