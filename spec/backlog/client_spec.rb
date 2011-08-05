# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Backlog::Client do
  context "特定のユーザのプロジェクトでAPIにアクセスする" do
    let(:space) { 'test' }
    let(:username) { 'yoppi' }
    let(:password) { 'hoge' }
    let(:client) {
      Backlog::Client.new(space, username, password)
    }

    it "Backlogにアクセスするクライアントオブジェクトが生成されること" do
      client.should_not be_nil
    end

    it "ユーザ名が取得できること" do
      client.username.should == username
    end

    it "スペース名が取得できること" do
      client.space.should == space
    end
  end
end
