require 'spec_helper'

describe Portfolio do

  it "should return array of portfolio values" do
    ports = Portfolio.new
     (ports.time_values.class == Array) .should be_true
  end

end

