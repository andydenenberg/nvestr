require 'spec_helper'

describe Comment do
  before(:each) do
    @post_attr = { 
      :title => "This a new Post",
      :body => 'The theme of this post is learning to test',
      :user_id => 1,
    }   
    @comment_attr = { 
      :note => "A note about something",
    }
  end
  
  it "should create a new instance given a valid attribute" do
    p = Post.create!(@post_attr)
    c = p.comments.create!(@comment_attr)
  end
end
