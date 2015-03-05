# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
UserToProject.destroy_all
UserProjectFollow.destroy_all
Project.destroy_all

def anyEmpty(*stuff)
  for s in stuff
    if s==nil or s == ""
      return true
    end
  end
  return false
end

def seed_user(name=nil,username=nil,password=nil)
  if anyEmpty(name,username,password)
    return nil
  end
  name = name.split(' ')
  first_name = name[0]
  last_name = name[1]
  email = "#{username}@connextor.co"
  User.create!(username:              username,
               email:                 email,
               first_name:            first_name,
               last_name:             last_name,
               password:              password,
               password_confirmation: password)
end


def seed_project(project_title=nil,project_short_description=nil,project_long_description=nil)
  if anyEmpty(project_title,project_long_description,project_long_description)
    return nil
  end
  Project.create!(title:             project_title,
                  short_description: project_short_description,
                  long_description:  project_long_description)
end


def seed_relationship(user_id=nil, project_id=nil)
  if anyEmpty(user_id,project_id)
    return nil
  end
  UserToProject.create!(user_id: user_id, project_id: project_id, project_user_class: ProjectUserClass::OWNER)
end

def seed_follow(user_id=nil, project_id=nil)
  if anyEmpty(user_id, project_id)
    return nil
  end
  UserProjectFollow.create!( user_id: user_id, project_id: project_id )
end

def generate_random_sequence( seq_size=0 )
  res = Array.new(seq_size, 0)
  for i in 1..seq_size do
    res[i] = rand(2)
  end
  return res
end


tot_users = 100
tot_projects = 30

# Creates 1000 random users
for n in 0..tot_users-1
  created_user = seed_user( Faker::Name.name, "user-#{n+1}", "user-#{n+1}@connextor.co" )
  # Creates a project for the first 300 users
  if n < tot_projects
    created_project = seed_project( Faker::App.name, Faker::Company.catch_phrase, Faker::Lorem.sentence(7) )
    seed_relationship(created_user.id, created_project.id)
  end
end

# Creates random follows from users to projects
userList = generate_random_sequence( 1000 )
for i in 0..tot_users-1 do
  if userList[i]==0
    next
  end
  projectList = generate_random_sequence( 300 )
  for j in 0..tot_projects-1 do
    if projectList[j]==1
      seed_follow( i, j )
    end
  end
end
