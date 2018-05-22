defmodule Appointment.Appointment do
  use Appointment.Web, :model

  schema "appointments" do
    field :description, :string
    
    belongs_to :user, Appointment.User
    belongs_to :state, Appointment.State
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset_new(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :user_id, :state_id])
    |> validate_required([:description, :user_id, :state_id])
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
  end

  def changeset_update(struct, params \\ %{}) do
    struct
    |> cast(params, [:description])
    |> validate_required([:description])
    |> put_change(:state_id, String.to_integer(params["state_id"]))
  end
end
