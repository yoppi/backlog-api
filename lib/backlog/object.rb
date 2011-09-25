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

    class DetailUser < User
      def initialize(user)
        super(user)
        @lang = user['lang']
        @updated_on = user['updated_on']
      end
      attr_reader :lang, :updated_on
    end

    class UserIcon
      def initialize(user_icon)
        @id = user_icon['id']
        @content_type = user_icon['content_type']
        # backlog.getUserIcon['data'] isn't encoded, so encode here.
        @data = XMLRPC::Base64.encode(user_icon['data']).delete("\n")
        @updated_on = user_icon['updated_on']
      end
      attr_reader :id, :content_type, :data, :updated_on
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
        @issue_type = issue['issue_type'] ? IssueType.new(issue['issue_type']) : nil
        @priority = issue['priority'] ? Priority.new(issue['priority']) : nil
        @resolution = issue['resolution'] ? Resolution.new(issue['resolution']) : nil
        @status = issue['status'] ? Status.new(issue['status']) : nil
        @components = issue['components'] ? issue['components'].map {|x| Component.new(x) } : []
        @versions = issue['versions'] ? issue['versions'].map {|x| Version.new(x) } : []
        @milestones = issue['milestone'] ? issue['milestones'].map {|x| Milestone.new(x)} : []
        @created_user = issue['created_user'] ? User.new(issue['created_user']) : nil
        @assigner = issue['assigner'] ? User.new(issue['assigner']) : nil
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

    class Item
      def initialize(item)
        @id = item['id']
        @name = item['name']
      end
    end

    class Milestone
      def initialize(milestone)
        @id = milestone['id']
        @name = milestone['name']
        @date = milestone['date']
      end
      attr_reader :id, :name, :date
    end

    class Comment
      def initialize(comment)
        @id = comment['id']
        @content = comment['content']
        @created_user = User.new(comment['created_user'])
        @created_on = comment['created_on']
        @updated_on = comment['updated_on']
      end
      attr_reader :id, :content, :created_user, :created_on, :updated_on
    end

    class Timeline
      def initialize(timeline)
        @type = timeline['type'] ? ActivityType.new(timeline['type']) : nil
        @content = timeline['content']
        @updated_on = timeline['updated_on']
        @user = timeline['user'] ? User.new(timeline['user']) : nil
        @issue = timeline['issue'] ? Issue.new(timeline['issue']) : nil
      end
      attr_reader :type, :content, :updated_on, :user, :issue
    end

    class ActivityType
      def initialize(activity_type)
        @id = activity_type['id']
        @name = activity_type['name']
      end
      attr_reader :id, :name
    end

    class CustomField
      def initialize(custom_field)
        @id = custom_field['id']
        @type_id = custom_field['type_id']
        @name = custom_field['name']
        @description = custom_field['description']
        @required = custom_field['required']
        if custom_field['issue_types']
          @issue_types = custom_field['issue_types'].map {|issue_type| IssueType.new(issue_type) }
        end
        # custom_field type is Number(type_id = 3)
        @min = custom_field['min']
        @max = custom_field['max']
        @initial_value = custom_field['initial_value']
        @unit = custom_field['unit']
        # custom_field type is Date(type_id = 4)
        @initial_value_type = custom_field['initial_value_type']
        @initial_shift = custom_field['initial_shift']
        @initial_date = custom_field['initial_date']
        # custom_field type is List(type_id = 5,6)
        if custom_field['items']
          @items = custom_field['items'].map {|item| Item.new(item)}
        end
        # custom_field type is CheckBox or RadioButton(type_id = 7,8)
        @allow_input = custom_field['allow_input']
      end
      attr_reader :id, :type_id, :name, :description, :required,
                  :issue_types,
                  :min, :max, :initial_value, :unit,
                  :initial_value_type, :initial_shift, :initial_date,
                  :items,
                  :allow_input
    end
  end
end
