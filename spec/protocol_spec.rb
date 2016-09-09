require 'spec_helper'

describe "Environment" do

  it "supported environments exist" do
    Origen.environment.exists?('default').should == true
    Origen.environment.exists?('93k').should == true
    Origen.environment.exists?('j750').should == true
    Origen.environment.exists?('v93k').should == true
  end


end
