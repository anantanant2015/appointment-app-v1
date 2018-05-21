defimpl Canada.Can, for: User do
  alias Appointment.{User, Role, Appointment, State}

  def can?(%User{id: user_id}, action, %Appointment{user_id: user_id})
    when action in [:update, :show, :new, :create], do: true

  def can?(%User{role: "admin"}, action, _)
    when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true

  def can?(%User{role: "admin"}, action, Role)
    when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true
  
  def can?(%User{role: "admin"}, action, State)
    when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true
  
  def can?(%User{role: "admin"}, action, Role)
    when action in [:update, :show, :new, :create, :index, :edit, :cancel, :delete], do: true
end