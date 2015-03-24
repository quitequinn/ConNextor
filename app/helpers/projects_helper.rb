module ProjectsHelper
  def isFollowingProject (user_id, project_id )
    UserProjectFollow.find_by_user_id_and_project_id( current_user_id, project_id ) 
  end

  def getUserProjectFollow(user_id, project_id )
    UserProjectFollow.find_by_user_id_and_project_id( current_user_id, project_id )
  end
end
