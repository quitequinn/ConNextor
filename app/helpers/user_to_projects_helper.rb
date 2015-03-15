module UserToProjectsHelper

  def IsInProject(user_id, project_id)
    UserToProject.find_by_user_id_and_project_id(user_id, project_id) != nil
  end
end
