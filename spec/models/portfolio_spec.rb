require 'spec_helper'

describe Portfolio do

  before(:each) do
    @attr = { 
      :name => "New Portfolio",
      :cash => 100000,
      :user_id => 1,
    }
  end
  
  it "should create a new instance given a valid attribute" do
    Portfolio.create!(@attr)
  end

  it "should return array of portfolio values" do
    ports = Portfolio.new
     (ports.time_values.class == Array) .should be_true
  end

end

