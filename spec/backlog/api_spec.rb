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
        @client.get_projects.class.should == Array
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
        @client.get_project(100).class.should == Backlog::Object::Project
      end

      it "keyを指定してプロジェクトを取得できる" do
        @client.get_project("key").class.should == Backlog::Object::Project
      end
    end
  end

  describe "カテゴリAPI" do
    context "プロジェクトのカテゴリを取得する" do
      let(:component) {
        [{"id" => 100,
          "name" => "カテゴリ名"}]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { component }
      end

      it "指定したプロジェクトのカテゴリが取得できる" do
        @client.get_components(100).class.should == Array
      end

      it "取得したカテゴリはすべてカテゴリオブジェクトである" do
        @client.get_components(100).each {|component|
          component.class.should == Backlog::Object::Component
        }
      end
    end
  end

  describe "バージョンAPI" do
    context "プロジェクトの発生バージョン/マイルストーンを取得する" do
      let(:version) {
        [{"id" => 733,
          "name" => "サイトオープン",
          "date" => "20110808"}]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { version }
      end

      it "プロジェクトを指定して発生バージョンが取得できる" do
        @client.get_versions(100).class.should == Array
      end
    end
  end

  describe "ユーザAPI" do
    context "プロジェクトの参加メンバーを取得する" do
      let(:user) {
        [{"id" => 1000,
          "name" => "yoppi"}]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args{ user }
      end

      it "プロジェクトを指定してその参加メンバーを取得できる" do
        @client.get_users(100).class.should == Array
      end
    end
  end

  describe "イシューAPI" do
    context "プロジェクトのイシュータイプを取得する" do
      let(:issue_types) {
        [{"id" => 2000,
          "name" => "タスク",
          "color" => "#7ea800"
        }]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { issue_types }
      end

      it "プロジェクトを指定してそのイシュータイプのリストを取得する" do
        @client.get_issue_types(100).class.should == Array
      end

      it "イシュータイプのリスト要素はすべてイシュータイプオブジェクトである" do
        @client.get_issue_types(100).each {|issue_type|
          issue_type.class.should == Backlog::Object::IssueType
        }
      end
    end

    context "プロジェクトのイシューを取得する" do
      let(:issue) {
        {
          "id" => 1617103,
          "key" => "ISSUE-100",
          "summary" => "トップページのデザイン決定",
          "description" => "トップページのデザイン決定する",
          "url" => "https://test.backog.jp/view/ISSUE-100",
          "due_date" => "20110831",
          "start_date" => "20110720",
          "estimated_hours" => "100",
          "actual_hours" => "200",
          "issue_type" => {"id" => 2000,
                           "name" => "タスク",
                           "color" => "#7ea800"},
          "priority" => {"id" => 300, "name" => "中"},
          "resolution" => {"id" => 400, "name" => "対応済み"},
          "status" => {"id" => 2, "name" => "処理中"},
          "components" => [{"id" => 100,
                            "name" => "カテゴリ名"}],
          "versions" => [{"id" => 733,
                          "name" => "サイトオープン",
                          "date" => "20110808"}],
          "milestones" => [{"id" => 800,
                            "name" => "8/21リリース",
                            "date" => "20110821"}],
          "created_user" => {"id" => 1000, "name" => "yoppi"},
          "assigner" => {"id" => 1000, "name" => "yoppi"},
          "created_on" => "20110701",
          "updated_on" => "20110807",
          "custom_fields" => []
        }
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { issue }
      end

      it "課題キーを指定してイシューを取得できる" do
        @client.get_issue("ISSUE-100").class.should == Backlog::Object::Issue
      end
    end
  end
end
