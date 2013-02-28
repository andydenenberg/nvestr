require 'spec_helper'

describe Post do
  before(:each) do
    @attr = { 
      :title => "This a new Post",
      :body => 'The theme of this post is learning to test',
      :user_id => 1,
    }
  end
  
  it "should create a new instance given a valid attribute" do
    Post.create!(@attr)
  end
end
