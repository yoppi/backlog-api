# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Backlog::API do
  before(:each) do
    @client = Backlog::Client.new("hoge", "yoppi", "test")
  end

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
        mock(@client).call.with_any_args{ user }
      end

      it "プロジェクトを指定してその参加メンバーを取得できる" do
        @client.get_users(100).class.should == Array
      end
    end

    context "特定のユーザの情報を取得する" do
      let(:user) {
        {"id" => 1000,
         "name" => "yoppi",
         "lang" => "ja",
         "updated_on" => "20110807220000"}
      }

      before do
        mock(@client).call.with_any_args { user }
      end

      it "ユーザIDを指定してそのユーザの情報を取得する" do
        @client.get_user(100).class.should == Backlog::Object::DetailUser
      end
    end

    context "特定のユーザのアイコンを取得する" do
      let(:user_icon) {
        {
          "id" => 1000,
          "content_type" => "image/gif",
          "data" => "/9j/4AAQSkZJRgABAgAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAAgACADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDMvWNpEHL5ycCo00rV7+NZrOylkjI+WR2VB+GeTVhGjQj7UHlfP7uN+Ax/Ht7f4VPa+OjoupS2GrSRb5pEaKOINiFWHG7PUng8V51SpKWkS8Jg4RSnUMqa11OwkEd9ZmPJwr5DZP1FNMUjA5P4cf4VtJd6rHbyQa1HBcRnMnnRMeUyTg579uPSqTPAw2wENH2yBkd8E06NR35WZ47CRSdSI3QbG28NXD3K3VzdyyZUxTMNiruU9upwDzx19zXPa3px1DxAuoopQZU5LZ6etd/d2EUwIkwy9RkYwayZrRg4KuVRei8VsoPmuc7xb5bET6hBLZGOVH85YNkc0e5eSSWDAHG0/J2zwazrJVt1IjiOPUD7x/OtG437CAcA8deRTYLWadRicmNONoAGP0qPZ8slYcq7qQfMf//Z",
        }
      }

      before do
        mock(@client).call.with_any_args { user_icon }
      end

      it "ユーザを指定してそのユーザのアイコンが取得できる" do
        @client.get_user_icon(100).class.should == Backlog::Object::UserIcon
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
        mock(@client).call.with_any_args { issue }
      end

      it "課題キーを指定してイシューを取得できる" do
        @client.get_issue("ISSUE-100").class.should == Backlog::Object::Issue
      end
    end
  end

  describe "コメントAPI" do
    context "イシューのコメントを取得する" do
      let(:comments) {
        [{"id" => "12889281",
          "content" => "ここはもっとシンプルなデザインがいいと思いました。",
          "created_user" => {"id" => 100, "name" => "yoppi"},
          "created_on" => "20110808165300",
          "updated_on" => "20110808165300"
        }]
      }

      before do
        mock(@client).call.with_any_args { comments }
      end

      it "指定したイシューのコメントが取得できる" do
        @client.get_comments(1000).class.should == Array
      end
    end
  end

  describe "タイムラインAPI" do
    context "タイムライン(イシューの更新情報)の一覧を取得する" do
      let(:timeline) {
        [{
          "type" => {"id" => 1, "name" => "更新"},
          "content" => "着手しました",
          "updated_on" => "20110807194600",
          "user" => {"id" => 100, "name" => "yoppi"},
          "issue" => {"id" => "73", "key" => "ISSUE-100",
                      "summary" => "トップページのデザイン決定",
                      "description" => "トップページのデザイン決定します",
                      "priority" => {"id" => 2, "name" => "中"}}
        }]
      }

      before do
        mock(@client).call.with_any_args { timeline }
      end

      it "タイムラインの一覧が取得できる" do
        @client.get_timeline().class.should == Array
      end
    end
  end

  describe "イシューの更新情報の種別一覧API" do
    let(:activity_types) {
      [
        {"id" => 100,
         "name" => "課題"}
      ]
    }

    before do
      mock(@client).call.with_any_args { activity_types }
    end

    it "イシューの更新情報の種別一覧を取得できる" do
      @client.get_activity_types().class.should == Array
    end

    it "各種別のオブジェクトであること" do
      @client.get_activity_types().each {|activity_type|
        activity_type.class.should == Backlog::Object::ActivityType
      }
    end
  end

  describe "イシュー状態API" do
    let(:statuses) {
      [{"id" => 4, "name" => "完了"}]
    }

    before do
      mock(@client).call.with_any_args { statuses }
    end

    it "イシューの状態一覧を取得できる" do
      @client.get_statuses().class.should == Array
    end

    it "取得したイシューの状態一覧の各状態はStatusオブジェクトであること" do
      @client.get_statuses().each {|status|
        status.class.should == Backlog::Object::Status
      }
    end
  end

  describe "イシュー完了理由API" do
    let(:resolutions) {
      [{"id" => 0, "name" => "対応済み"}]
    }

    before do
      mock(@client).call.with_any_args { resolutions }
    end

    it "イシューの完了理由一覧を取得できる" do
      @client.get_resolutions().class.should == Array
    end

    it "取得したイシューの完了理由一覧はResolutionオブジェクトであること" do
      @client.get_resolutions().each {|resolution|
        resolution.class.should == Backlog::Object::Resolution
      }
    end
  end

  describe "イシューの優先度一覧取得API" do
    let(:priorities) {
      [{"id" => 3, "name" => "中"}]
    }

    before do
      mock(@client).call.with_any_args { priorities }
    end

    it "イシューの優先度一覧を取得できる" do
      @client.get_priorities().class.should == Array
    end

    it "取得したイシューの各優先度はPriorityオブジェクトであること" do
      @client.get_priorities().each {|priority|
        priority.class.should == Backlog::Object::Priority
      }
    end
  end

  describe "カスタム属性の情報取得API" do
    context "カスタム属性タイプが文字列の場合" do
      let(:custom_fields_1) {
        [{"id" => 4,
          "type_id" => 1,
          "name" => "OS",
          "description" => "現象が発生したOS",
          "required" => 1,
          "issue_types" => [{"id" => 5, "name" => "バグ", "color" => "#990000"}]}]
      }

      before do
        mock(@client).call.with_any_args { custom_fields_1 }
      end

      it "プロジェクトIDを指定して登録しているカスタム属性の情報を取得できる" do
        @client.get_custom_fields(100).class.should == Array
      end

      it "プロジェクトIDをissue_type_idを指定して登録しているカスタム属性の情報を取得できる" do
        @client.get_custom_fields(100, 10).class.should == Array
      end

      it "プロジェクトIDをissue_typeを指定して登録しているカスタム属性の情報を取得できる" do
        @client.get_custom_fields(100, "バグ").class.should == Array
      end

      it "取得したカスタム属性情報はCustomFieldsオブジェクトであること" do
        @client.get_custom_fields(100).each {|custom_field|
          custom_field.class.should == Backlog::Object::CustomField
          custom_field.id.should == custom_fields_1.first["id"]
          custom_field.type_id.should == custom_fields_1.first["type_id"]
          custom_field.name.should == custom_fields_1.first["name"]
          custom_field.description.should == custom_fields_1.first["description"]
          custom_field.required.should == custom_fields_1.first["required"]
          custom_field.issue_types.class.should == Array
          custom_field.issue_types.each {|issue_type|
            issue_type.class.should == Backlog::Object::IssueType
            issue_type.id.should == custom_fields_1.first["issue_types"].first["id"]
            issue_type.name.should == custom_fields_1.first["issue_types"].first["name"]
            issue_type.color.should == custom_fields_1.first["issue_types"].first["color"]
          }
        }
      end
    end

    context "カスタム属性タイプが数値の場合" do
      let(:custom_fields_3) {
        [{"id" => 10,
          "type_id" => 3,
          "name" => "割合",
          "description" => "発生した割合",
          "required" => 1,
          "issue_types" => [{"id" => 5, "name" => "バグ", "color" => "#990000"}],
          "min" => 0.0,
          "max" => 100.0,
          "initial_value" => 0.0,
          "unit" => "%"
        }]
      }

      before do
        mock(@client).call.with_any_args { custom_fields_3 }
      end

      it "取得したカスタム属性情報はCustomFieldオブジェクトであること" do
        @client.get_custom_fields(100).each {|custom_field|
          custom_field.min.should == custom_fields_3.first["min"]
          custom_field.max.should == custom_fields_3.first["max"]
          custom_field.initial_value.should == custom_fields_3.first["initial_value"]
          custom_field.unit.should == custom_fields_3.first["unit"]
        }
      end
    end

    context "カスタム属性タイプが日付の場合" do
      let(:custom_fields_4) {
        [{"id" => 20,
          "type_id" => 4,
          "name" => "日付",
          "description" => "発生した日付",
          "required" => 1,
          "issue_types" => [{"id" => 5, "name" => "バグ", "color" => "#990000"}],
          "initial_value_type" => 1,
          "min" => 100.0,
          "max" => 0.0,
        }]
      }

      before do
        mock(@client).call.with_any_args { custom_fields_4 }
      end

      it "取得したカスタム属性情報はCustomFieldオブジェクトであること" do
        @client.get_custom_fields(100).each {|custom_field|
          custom_field.initial_value_type.should == custom_fields_4.first["initial_value_type"]
          custom_field.min.should == custom_fields_4.first["min"]
          custom_field.max.should == custom_fields_4.first["max"]
        }
      end
    end

    context "カスタム属性タイプがリストの場合" do
      let(:custom_fields_5) {
        [{"id" => 20,
          "type_id" => 5,
          "name" => "OS",
          "description" => "発生したOS",
          "required" => 1,
          "issue_types" => [{"id" => 5, "name" => "バグ", "color" => "#990000"}],
          "items" => [{"id" => 1, "name" => "windows"}]
        }]
      }

      before do
        mock(@client).call.with_any_args { custom_fields_5 }
      end

      it "取得したカスタム属性情報はCustomFieldオブジェクトであること" do
        @client.get_custom_fields(100).each {|custom_field|
          custom_field.items.class == Array
          custom_field.items.each {|item|
            item.class.should == Backlog::Object::Item
          }
        }
      end
    end

    context "カスタム属性タイプがチェックボックスの場合" do
      let(:custom_fields_7) {
        [{"id" => 20,
          "type_id" => 5,
          "name" => "OS",
          "description" => "発生したOS",
          "required" => 1,
          "issue_types" => [{"id" => 5, "name" => "バグ", "color" => "#990000"}],
          "allow_input" => "1",
          "items" => [{"id" => 1, "name" => "windows"}]
        }]
      }

      before do
        mock(@client).call.with_any_args { custom_fields_7 }
      end

      it "取得したカスタム属性情報はCustomFieldオブジェクトであること" do
        @client.get_custom_fields(100).each {|custom_field|
          custom_field.allow_input.should == custom_fields_7.first['allow_input']
        }
      end
    end
  end

  describe "イシュー件数検索API" do
    context "クエリにproject_idがない場合" do
      let(:condition) {
        {"issueTypeId" => 100}
      }
      it "例外が発生する" do
        expect { @client.count_issue(condition) }.should raise_error(Backlog::API::ArgumentError)
      end
    end
    context "指定した検索条件で検索する" do
      let(:condition) {
        {
          "projectId" => 100,
          "issueTypeId" => 10
        }
      }
      before do
        mock(@client).call.with_any_args { 1 }
      end
      it "指定した検索条件で検索できる" do
        @client.count_issue(condition).should == 1
      end
    end
  end
end
