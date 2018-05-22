defimpl Canada.Can, for: Appointment.User do
  alias Appointment.{User, Role, Appointment, State}

  def can?(%User{id: id, role_id: role_id}, action, %User{id: id, role_id: 2})
    when action in [:update, :show, :new, :create], do: true

  def can?(%User{id: id, role_id: role_id}, action, Appointment)
    when action in [:update, :show, :new, :create], do: true

  def can?(%User{id: id, role_id: role_id}, action, Role)
    when action in [:update, :show, :new, :create] and role_id == 2, do: true

  def can?(%User{id: id, role_id: role_id}, action, %User{id: id, role_id: 1})
    when action in [:show, :create], do: true

  def can?(%User{id: id, role_id: role_id}, action, %User{id: id, role_id: 1})
    when action in [:show, :create], do: false
  # def can?(%User{role_id: "2"}, action, _)
  #   when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true

  # def can?(%User{role_id: "2"}, action, Role)
  #   when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true
  
  # def can?(%User{role_id: "2"}, action, State)
  #   when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true
  
  # def can?(%User{role_id: "2"}, action, Role)
  #   when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true
end