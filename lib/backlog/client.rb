# coding: utf-8

require 'xmlrpc/client'

module Backlog
  class Client
    def initialize(project_name, username, password)
      @project_name = project_name
      @username = username
      @password = password
    end
    attr_reader :project_name, :username, :password
  end
end
