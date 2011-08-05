# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Backlog::API do
  describe "プロジェクトAPI" do
    context "プロジェクトの一覧を取得する" do
      let(:projects) {
        [{"id" => 100,
          "name" => "test",
          "key" => "TEST",
          "url" => "http://hoge.backlog.jp/TEST",
          "archived" => false}]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { projects }
      end

      it "プロジェクトのリストを取得できる" do
        @client.get_projects.class == Array
      end
    end

    context "プロジェクトを取得する" do
      let(:project) {
        {"id" => 100,
          "name" => "test",
          "key" => "TEST",
          "url" => "http://hoge.backlog.jp/TEST",
          "archived" => false}
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { project }
      end

      it "project_idを指定してプロジェクトを取得できる" do
        @client.get_project(100).class == Backlog::Object::Project
      end
    end
  end
end
