defimpl Canada.Can, for: Appointment.User do
  alias Appointment.{User, Role, Appointment, State}

  def can?(%User{role: %Role{ kind: kind}}, :show, %User{})
    when kind in ["admin", "user"] do
    true
  end

  def can?(%User{role: %Role{id: id, kind: "user"}}, :edit, %User{id: id}) do
    false
  end

  def can?(%User{role: %Role{ kind: "user"}}, :index, User) do
    false
  end

  def can?(%User{role: %Role{ kind: "user"}}, action, Appointment)
    when action in [:new, :show, :create] do
    true
  end

  def can?(%User{role: %Role{ kind: "user"}}, _, model)
    when model in [Role, Appointment, State] do
    false
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, User) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, %User{}) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, Appointment) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, %Appointment{}) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, Role) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, %Role{}) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, State) do
    true
  end

  def can?(%User{role: %Role{ kind: "admin"}}, _, %State{}) do
    true
  end

  def can?(_, _action, _) do
    false
  end
  
  # def can?(_, _action, _) do

  # def can?(%User{role_id: 2}, action, User)
  #   when action in [:index], do: true

  # def can?(%User{role_id: 2}, action, User)
  #   when action in [:update, :show, :new, :create], do: true

  # def can?(%User{role_id: 2}, action, Role)
  #   when action in [:update, :show, :new, :create], do: true

  # def can?(%User{role_id: 2}, action, Appointment)
  #   when action in [:update, :show, :new, :create], do: true

  # def can?(%User{role_id: 2}, action, State)
  #   when action in [:update, :show, :new, :create], do: true

  # def can?(%User{id: id, role_id: role_id}, action, %User{id: id, role_id: 2})
  #   when action in [:update, :show, :new, :create], do: true

  # def can?(%User{role_id: 2}, action, Appointment)
  #   when action in [:update, :show, :new, :create], do: true
  
  # def can?(_ , action, Appointment)
  #   when action in [:update, :show, :new, :create], do: false

  # def can?(_ , action, User)
  #   when action in [:update, :show, :new, :create], do: false

  # def can?(_ , action, Role)
  #   when action in [:update, :show, :new, :create], do: false

  # def can?(_ , action, State)
  #   when action in [:update, :show, :new, :create], do: false

  # def can?(%User{id: id, role_id: role_id}, action, Role)
  #   when action in [:update, :show, :new, :create] and role_id == 2, do: true

end