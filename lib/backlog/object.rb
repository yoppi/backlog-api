# coding: utf-8

module Backlog
  module Object
    class Project
      def initialize(project)
        @id = project['id']
        @name = project['name']
        @key = project['key']
        @url = project['url']
        @archived = project['archived']
      end
      attr_reader :id, :name, :key, :url, :archived
    end

    class Component
      def initialize(component)
        @id = component['id']
        @name = component['name']
      end
      attr_reader :id, :name
    end

    class Version
      def initialize(version)
        @id = version['id']
        @name = version['name']
        @date = version['date']
      end
      attr_reader :id, :name, :date
    end

    class User
      def initialize(user)
        @id = user['id']
        @name = user['name']
      end
      attr_reader :id, :name
    end

    class IssueType
      def initialize(issue_type)
        @id = issue_type['id']
        @name = issue_type['name']
        @color = issue_type['color']
      end
      attr_reader :id, :name, :color
    end

    class Issue
      def initialize(issue)
        @id = issue['id']
        @key = issue['key']
        @summary = issue['summary']
        @description = issue['description']
        @url = issue['url']
        @due_date = issue['due_date']
        @start_date = issue['start_date'],
        @estimated_hours = issue['estimated_hours']
        @actual_hours = issue['actual_hours']
        @issue_type = IssueType.new(issue['issue_type'])
        @priority = Priority.new(issue['priority'])
        @resolution = Resolution.new(issue['resolution'])
        @status = Status.new(issue['status'])
        @components = issue['components'].map {|x| Component.new(x) }
        @versions = issue['versions'].map {|x| Version.new(x) }
        @milestones = issue['milestones'].map {|x| Milestone.new(x)}
        @created_user = User.new(issue['created_user'])
        @assigner = User.new(issue['assigner'])
        @created_on = issue['created_on']
        @updated_on = issue['updated_on']
        @custom_fields = issue['custom_fields']
      end
      attr_reader :id, :key, :summary, :description, :url,
                  :due_date, :start_date, :estimated_hours,
                  :actual_hours, :issue_type, :priority,
                  :resolution, :status, :components, :versions,
                  :milestones, :created_user, :assigner,
                  :created_on, :updated_on, :custom_fields
    end

    class Priority
      def initialize(priority)
        @id = priority['id']
        @name = priority['name']
      end
      attr_reader :id, :name
    end

    class Resolution
      def initialize(resolution)
        @id = resolution['id']
        @name = resolution['name']
      end
      attr_reader :id, :name
    end

    class Status
      def initialize(status)
        @id = status['id']
        @name = status['name']
      end
      attr_reader :id, :name
    end

    class Milestone
      def initialize(milestone)
        @id = milestone['id']
        @name = milestone['name']
        @date = milestone['date']
      end
      attr_reader :id, :name, :date
    end
  end
end
