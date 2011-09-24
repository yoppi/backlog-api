# coding: utf-8

require 'xmlrpc/client'

module Backlog
  class Client
    include API

    BACKLOG_API = "https://%s:%s@%s.backlog.jp/XML-RPC"

    def initialize(space, username, password)
      @space = space
      @username = username
      @password = password
      @client = XMLRPC::Client.new2(BACKLOG_API % [@username, @password, @space])
    end
    attr_reader :space, :username, :password, :client

    def call(method, args=nil)
      if args
        @client.call(method, args)
      else
        @client.call(method)
      end
    end
  end
end
