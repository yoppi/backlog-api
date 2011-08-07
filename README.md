# backlog-api
A library to Easy Access Backlog(http://www.backlog.jp) API from Ruby.

## Installation
Ok, you just type

    $ gem install backlog-api

## How to use
First, create backlog client to accessing API.
Second, call API

    require 'backlog-api'
    backlog = Backlog::Client.new("space", "user", "password")
    # get Project List
    projects = backlog.get_projects()
    # get Issue
    issue = backlog.get_issue("issue_key")
 
## Copyright
Copyright (c) 2011 yoppi. See LICENSE.txt for further details.

