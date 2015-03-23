module ProfilesHelper

  # Takes in object that belongs-to profile
  # Checks whether its profile is the same as the current user's
  def has_profile_permission?(object)
    object and object.profile and current_user and object.profile == current_user.profile
  end
end
