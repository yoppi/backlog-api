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
  end
end
