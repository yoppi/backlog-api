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
  end
end
