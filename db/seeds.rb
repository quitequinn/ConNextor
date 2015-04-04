# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
load 'db/cities_parser.rb'

UserToProject.destroy_all
UserProjectFollow.destroy_all
User.destroy_all
Skill.destroy_all
Interest.destroy_all
ProjectComment.destroy_all
ProjectPost.destroy_all
ProjectPost.destroy_all
ProjectToTag.destroy_all
ProjectTag.destroy_all
# This v is causing problems with a standard seed, no idea why. it says a column doesnt exist, tried to delete everything but nothing happened.
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

def seed_skill(name=nil)
  if anyEmpty(name)
    return nil
  end
  Skill.create!(name: name)
end

def seed_interest(name=nil)
  if anyEmpty(name)
    return nil
  end
  Interest.create!(name: name)
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

def seed_users_projects( tot_users=0, tot_projects=0 )
  # Creates tot_users random users
  # tot_projects = [ tot_users, tot_projects ].min
  first_user_id = 0
  first_project_id = 0
  
  for n in 1..tot_users
    created_user = seed_user( Faker::Name.name, "user-#{n}", "foobar" )
    if n==1
      first_user_id = created_user.id
    end
    # Creates a project for the first tot_projects users
    if n <= tot_projects
      created_project = seed_project( Faker::App.name, Faker::Company.catch_phrase, Faker::Lorem.sentence(25) )
      seed_relationship(created_user.id, created_project.id)
      if n==1
         first_project_id = created_project.id
      end
    end
  end

  # Creates random follows from users to projects
  for i in 1..tot_users do
    projectList = generate_random_sequence( tot_projects )
    for j in 1..tot_projects do
      if projectList[j]==1
        seed_follow( i + first_user_id - 1, j + first_project_id - 1 )
      end
    end
  end

  return 1
end

seed_skill('frontend')
seed_skill('backend')
seed_skill('design')
seed_skill('logic')
seed_skill('management')
seed_skill('business')

seed_interest('frontend')
seed_interest('backend')
seed_interest('design')
seed_interest('logic')
seed_interest('management')
seed_interest('business')

seed_users_projects( 200, 70 )       

seed_world
