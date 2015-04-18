module ProjectStage
  PRODUCTION = 'Production'
  DEVELOPMENT = 'Development'
  DESIGN = 'Design'
  CONCEPT = 'Concept'

  STAGES = [PRODUCTION, DEVELOPMENT, DESIGN, CONCEPT]
end

module ProjectUserClass
  OWNER = 'Ownership'
  CORE_MEMBER = 'Core Membership'
  CONTRIBUTOR = 'Contribution'
  PENDING = 'Pending Approval'

  CLASSES = [OWNER, CORE_MEMBER, CONTRIBUTOR, PENDING]
end

module ProjectTaskState
  COMPLETE = 'Complete'
  ASSIGNED = 'Assigned'
  UNASSIGNED = 'Unassigned'
  DRAFT = 'Draft'

  STATES = [COMPLETE, ASSIGNED, UNASSIGNED, DRAFT]
end

module UserTaskStatus
  COMPLETED = 'Completed'
  IN_PROGRESS = 'In Progress'
  DROPPED = 'Dropped'

  STATUSES = [COMPLETED, IN_PROGRESS, DROPPED]
end

module ASANA
  API_URL = 'https://app.asana.com/api/1.0'
end