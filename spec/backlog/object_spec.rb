# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Backlog::Object::FindCondition do
  let(:params) {
    {
      "projectId" => 100,
      "issueTypeId" => 10
    }
  }
  it "指定したHashのパラメータが登録されていること" do
    o = Backlog::Object::FindCondition.new(params)
    o.projectId.should == params["projectId"]
    o.issueTypeId.should == params["issueTypeId"]
  end
  it "Hashに変換できること" do
    h = Backlog::Object::FindCondition.new(params).to_h
    h["projectId"].should == params["projectId"]
    h["issueTypeId"].should == params["issueTypeId"]
  end
end
