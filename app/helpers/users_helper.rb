module UsersHelper

  def isFollowingUser( follower_id, followee_id )
    UserFollow.find_by_follower_id_and_followee_id( follower_id, followee_id )
  end

  def getFollowingUser( follower_id, followee_id )
    UserFollow.find_by_follower_id_and_followee_id( follower_id, followee_id )
  end

end
