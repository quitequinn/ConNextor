class Position < ActiveRecord::Base
  belongs_to :projects

  def self.applied(user, position_id)
    Request.find_by_sender_id_and_request_type_id(user.id, position_id)
  end
end
