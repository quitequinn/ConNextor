# ####################################
#            Database Seed
# ####################################

# #########
#  Helpers
# #########

# Users Profiles and Projects (padding only for development)

def seed_user_with_profile(name=nil, email=nil, password=nil)
  return nil if any_empty(name, email, password)

  name = name.split(' ')
  first_name = name[0]
  last_name = name[1]
  # email = "#{username}@connextor.co"

  User.create!(
      # username:              username,
      email:                 email,
      first_name:            first_name,
      last_name:             last_name,
      password:              password,
      password_confirmation: password
  )
end

def seed_project(title=nil, short_description=nil,long_description=nil)
  return nil if any_empty(title, short_description, long_description)
  Project.create!(
      title:             title,
      short_description: short_description,
      long_description:  long_description
  )
end

# Follows and Relationships

def seed_follow(user_id=nil, project_id=nil)
  return nil if any_empty(user_id, project_id)
  UserProjectFollow.create!( user_id: user_id, project_id: project_id )
end

def seed_relationship(user_id=nil, project_id=nil)
  return nil if any_empty(user_id,project_id)
  UserToProject.create!(user_id: user_id, project_id: project_id, project_user_class: ProjectUserClass::OWNER)
end

# Skills and Interests

def seed_skill(name=nil)
  return nil if any_empty(name)
  Skill.create!(name: name)
end

def seed_interest(name=nil)
  return nil if any_empty(name)
  Interest.create!(name: name)
end

# Invitation Codes

def seed_invite(code=nil)
  return nil if any_empty(code)
  InvitationCode.create!(code: code)
end

# Miscellaneous

def any_empty(*stuff)
  for s in stuff
    if s==nil or s == ''
      return true
    end
  end
  false
end

def generate_random_sequence(seq_size=0)
  res = Array.new(seq_size, 0)
  for i in 1..seq_size do
    res[i] = rand(2)
  end
  res
end


# #########
#  Seeding
# #########

User.destroy_all
Profile.destroy_all
Project.destroy_all

# tot_users = 500
# tot_projects = 100
#
# # Creates tot_users random users
# for n in 1..tot_users
#   created_user = seed_user( Faker::Name.name, "user-#{n+1}", "user-#{n+1}@connextor.co" )
#   # Creates a project for the first tot_projects users
#   if n <= tot_projects
#     created_project = seed_project( Faker::App.name, Faker::Company.catch_phrase, Faker::Lorem.sentence(25) )
#     seed_relationship(created_user.id, created_project.id)
#   end
# end
#
# # Creates random follows from users to projects
# for i in 1..tot_users do
#   projectList = generate_random_sequence( tot_projects )
#   for j in 1..tot_projects do
#     if projectList[j]==1
#       seed_follow( i, j )
#     end
#   end
# end

Skill.destroy_all

# seed_skill('frontend')
# seed_skill('backend')
# seed_skill('design')
# seed_skill('logic')
# seed_skill('management')
# seed_skill('business')

Interest.destroy_all

seed_interest('Back-end Engineer')
seed_interest('Business Developer')
seed_interest('Designer')
seed_interest('Front-end Engineer')
seed_interest('Hardware Engineer')
seed_interest('Marketer')
seed_interest('Mobile Developer')
seed_interest('Product Manager')

InvitationCode.destroy_all

seed_invite('WATERLOOWARRIORS')
seed_invite('BEDFORDSCHMUCKS')

InvitationRequest.destroy_all

