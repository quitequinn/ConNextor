module ProjectMeta
  CLOSED = 'closed'.freeze
  ALPHA = 'alpha'.freeze
  BETA = 'beta'.freeze
  PUBLIC_RELEASE = 'public'.freeze

  PHASES = [CLOSED, ALPHA, BETA, PUBLIC_RELEASE].freeze

  INVITATION_PHASES = [CLOSED, ALPHA].freeze
  AUTHENTICATION_PHASES = [ALPHA, BETA, PUBLIC_RELEASE].freeze

  CURRENT_PHASE = ENV['connextor_project_phase'] || CLOSED
end

module ProjectStage
  PRODUCTION = 'Production'.freeze
  DEVELOPMENT = 'Development'.freeze
  DESIGN = 'Design'.freeze
  CONCEPT = 'Concept'.freeze

  STAGES = [PRODUCTION, DEVELOPMENT, DESIGN, CONCEPT].freeze
end

module ProjectUserClass
  OWNER = 'Ownership'.freeze
  CORE_MEMBER = 'Core Membership'.freeze
  CONTRIBUTOR = 'Contribution'.freeze
  PENDING = 'Pending Approval'.freeze

  CLASSES = [OWNER, CORE_MEMBER, CONTRIBUTOR, PENDING].freeze
end

module ProjectTaskState
  COMPLETE = 'Complete'.freeze
  ASSIGNED = 'Assigned'.freeze
  UNASSIGNED = 'Unassigned'.freeze
  DRAFT = 'Draft'.freeze

  STATES = [COMPLETE, ASSIGNED, UNASSIGNED, DRAFT].freeze
end

module UserTaskStatus
  COMPLETED = 'Completed'
  IN_PROGRESS = 'In Progress'
  DROPPED = 'Dropped'

  STATUSES = [COMPLETED, IN_PROGRESS, DROPPED]
end
