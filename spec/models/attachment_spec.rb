require 'spec_helper'

describe Attachment do
  before(:each) do
    @post_attr = { 
      :title => "This a new Post",
      :body => 'The theme of this post is learning to test',
      :user_id => 1,
    }   
    @attachment_attr = { 
      :description => "something about the attachment",
      :url => 'www.url.com',
    }
  end
  
  it "should create a new instance given a valid attribute" do
    p = Post.create!(@post_attr)
    c = p.attachments.create!(@attachment_attr)
  end
end
