module UsersHelper

  # Takes in object that belongs-to user
  # Checks whether its user is the same as the current user
  def has_user_permission?(object)
    object and object.user and current_user and object.user == current_user
  end
end
