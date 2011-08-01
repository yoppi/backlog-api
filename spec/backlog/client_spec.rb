# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Backlog::Client do
  context "特定のユーザのプロジェクトでAPIにアクセスする" do
    it "Backlogにアクセスするクライアントオブジェクトが生成されること" do
      client = Backlog::Client.new()
      client.should_not be_nil
    end
  end
end
