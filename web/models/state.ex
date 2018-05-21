defmodule Appointment.State do
  use Appointment.Web, :model

  schema "states" do
    field :name, :string
    
    # has_many :appointments, Appointment.Appointment
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
