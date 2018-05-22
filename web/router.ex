defmodule Appointment.Router do
  use Appointment.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug Guardian.Plug.VerifySession, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
    # plug Guardian.Plug.LoadResource, allow_blank: true, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
    plug Guardian.Plug.LoadResource, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
  end

  pipeline :require_login do
    # plug Guardian.Plug.EnsureAuthenticated, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
    plug Appointment.Plug.CurrentUser, module: Appointment.Guardian, error_handler: Appointment.AuthErrorHandler
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
    pipe_through [:browser]#, :browser_session, :require_login]

    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    get "/users/:id/edit", UserController, :edit
    put "/users/:id", UserController, :update

    get "/admin/:id", AdminController, :show
    get "/admin/:id/edit", AdminController, :edit
    put "/admin/:id", AdminController, :update
    delete "/admin/:id", AdminController, :delete
    get "/admin", AdminController, :show_all
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
