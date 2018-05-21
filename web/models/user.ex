defmodule Appointment.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Appointment.{User, Encryption, Role, Repo}

    schema "users" do
      field :hashed_password, :string
      # field :role, :string
      field :name, :string
      field :email, :string
      # field :role, :string

      # Add a virtual attribute to hold plain text passwords.
      field :password, :string, virtual: true
      field :password_confirmation, :string, virtual: true
      has_many :appointments, Appointment.Appointment
      belongs_to :role, Appointment.Role

      timestamps()
    end

    @required_fields ~w(email name password)
    @optional_fields ~w()
    @all_fields ~w(email name password role_id)
    @doc false
    def changeset(%User{} = user, attrs) do
      user

      # Cast and require a password for each user
      |> cast(attrs, @required_fields)
      # |> put_assoc(:role, get_role(attrs))
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 6)
      |> downcase_email
      |> unique_constraint(:email)
      |> validate_confirmation(:password)
      # |> add_role

      # Hash passwords before saving them to the database.
      |> put_hashed_password()
    end

    def register_changeset(%User{} = user, attrs, role_id) do
      user
      # Cast and require a password for each user
      |> cast(attrs, ~w(email name password))

      # |> cast_assoc(:role_id)
      # |> cast(attrs, @required_fields, @optional_fields)
      |> put_change(:role_id, role_id)
      # |> Repo.preload(:role)
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 6)
      |> downcase_email
      |> unique_constraint(:email)
      |> validate_confirmation(:password)
      # |> add_role

      # Hash passwords before saving them to the database.
      |> put_hashed_password()
    end

    defp get_role(role_id) do
      Repo.get(Role, String.to_integer(role_id))
    end

    defp put_role(changeset, role_id) do
      case changeset do
        %Ecto.Changeset{valid?: true, changes: %{role_id: role_id}} ->
          put_assoc(changeset, :role_id, role_id)
        _ ->
          changeset
      end
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