class Project < ActiveRecord::Base
  validates :title, :short_description, presence: true
  
end
