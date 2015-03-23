module ProfilesHelper

  # Takes in object that belongs-to profile
  # Checks whether its profile is the same as the current user's
  def has_profile_permission?(object)
    logger.error object.profile
    logger.error current_user.profile
    object and object.profile and current_user and object.profile == current_user.profile
  end
end
