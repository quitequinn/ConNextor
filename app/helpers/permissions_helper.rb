module PermissionsHelper
  # Takes in object that belongs-to profile
  # Checks whether its profile is the same as the current user's
  def has_profile_permission?(object)
    is_owner_of_profile = user_has_profile_object(object)
    redirect_to rooturl, notice: 'Wrong Permissions' unless is_owner_of_profile
    return false unless is_owner_of_profile
    true
  end
  
  def user_has_profile_object(object)
    object and object.profile and current_user and object.profile == current_user.profile
  end

  # Takes in object that belongs-to user
  # Checks whether its user is the same as the current user
  def has_user_permission?(object)
    object and object.user and current_user and object.user == current_user
  end

  def has_project_permission?(user_id, project_id)
    result = false
    user_to_project = UserToProject.find_by_user_id_and_project_id(user_id, project_id)
    if user_to_project
      result = user_to_project.project_user_class == ProjectUserClass::OWNER or 
              user_to_project.project_user_class == ProjectUserClass::CORE_MEMBER
    end
    result
  end

end