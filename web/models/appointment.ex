defmodule Appointment.Appointment do
  use Appointment.Web, :model

  schema "appointments" do
    field :description, :string
    field :user_id, :string
    field :state, :string
    # belongs_to :user, Appointment.User
    # belongs_to :state, Appointment.State
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
  end
end
