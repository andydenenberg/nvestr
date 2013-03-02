require 'spec_helper'

describe History do

  before(:each) do
    @hist_attr = { 
      :value => 100000,
      :cash => 1,
    }
    @port_attr = { 
      :name => "New Portfolio",
      :cash => 100000,
      :user_id => 1,
    }

  end
  
  it "should create a new instance given valid attributes" do
    port = Portfolio.create!(@port_attr)
    
    port.histories.create!(@hist_attr)
  end
end
