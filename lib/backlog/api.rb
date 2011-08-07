# coding: utf-8

module Backlog
  module API
    def get_projects
      self.call("backlog.getProjects").map {|project|
        Backlog::Object::Project.new(project)
      }
    end

    def get_project(key_or_project_id)
      Backlog::Object::Project.new(
        self.call("backlog.getProject", key_or_project_id)
      )
    end

    def get_components(project_id)
      self.call("backlog.getComponents", project_id).map {|component|
        Backlog::Object::Component.new(component)
      }
    end

    def get_versions(project_id)
      self.call("backlog.getVersions", project_id).map {|version|
        Backlog::Object::Version.new(version)
      }
    end

    def get_users(project_id)
      self.call("backlog.getUsers", project_id).map {|user|
        Backlog::Object::User.new(user)
      }
    end

    def get_issue_types(project_id)
      self.call("backlog.getIssueTypes", project_id).map {|issue_type|
        Backlog::Object::IssueType.new(issue_type)
      }
    end

    # String | Integer -> Backlog::Object::Issue
    def get_issue(issue_key)
      if issue_key.instance_of? String
        issue_key = issue_key.to_i.zero? ? issue_key : issue_key.to_i
      end
      Backlog::Object::Issue.new(
        self.call("backlog.getIssue", issue_key)
      )
    end

    def get_comments(issue_id)
      self.call("backlog.getComments", issue_id).map {|comment|
        Backlog::Object::Comment.new(comment)
      }
    end
  end
end
