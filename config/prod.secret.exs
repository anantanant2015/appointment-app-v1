use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :appointment, Appointment.Endpoint,
  secret_key_base: "KR80c7zwjQjmi3NVQgWrMZmjO5EJcbvm4Tjnsk5GdCcuMFE6vNKguqUp/kdvQFDa"

# Configure your database
config :appointment, Appointment.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "appointment_prod",
  pool_size: 20
