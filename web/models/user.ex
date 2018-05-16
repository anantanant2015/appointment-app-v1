defmodule Appointment.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Appointment.{User, Encryption}

    schema "users" do
      field :hashed_password, :string
      field :role, :string
      field :name, :string
      field :email, :string

      # Add a virtual attribute to hold plain text passwords.
      field :password, :string, virtual: true
      field :password_confirmation, :string, virtual: true

      timestamps()
    end

    @required_fields ~w(email name password role)
    @optional_fields ~w()
    @doc false
    def changeset(%User{} = user, attrs) do
      user

      # Cast and require a password for each user
      |> cast(attrs, @required_fields, @optional_fields)
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 6)
      |> downcase_email
      |> unique_constraint(:email)
      |> validate_confirmation(:password)

      # Hash passwords before saving them to the database.
      |> put_hashed_password()
    end

    defp put_hashed_password(changeset) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
          put_change(changeset, :hashed_password, Encryption.hash_password(password))
        _ ->
          changeset
      end
    end

    defp downcase_email(changeset) do
      update_change(changeset, :email, &String.downcase/1)
    end
end