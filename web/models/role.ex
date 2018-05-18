defmodule Appointment.Role do
  use Appointment.Web, :model

  schema "roles" do
    field :kind, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:kind])
    |> validate_required([:kind])
  end
end
