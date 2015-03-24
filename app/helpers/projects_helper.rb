module ProjectsHelper
  def isFollowingProject (user_id, project_id )
    UserProjectFollow.find_by_user_id_and_project_id( current_user_id, project_id ) 
  end

  def getUserProjectFollow(user_id, project_id )
    UserProjectFollow.find_by_user_id_and_project_id( current_user_id, project_id )
  end

  def getProjectOwner( project_id )
    UserToProject.find_by_project_id_and_project_user_class(project_id, ProjectUserClass::OWNER).user
  end
end
