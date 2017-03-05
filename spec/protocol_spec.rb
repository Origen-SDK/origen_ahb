require 'spec_helper'

describe "Environment" do

  before :all do
    Origen.environment.temporary = 'j750.rb'
    Origen.load_target('specs')
  end
  
  it "supported environments exist" do
    Origen.environment.exists?('default').should == true
    Origen.environment.exists?('93k').should == true
    Origen.environment.exists?('j750').should == true
    Origen.environment.exists?('v93k').should == true
  end

  it "get_hsize returns correct value" do
    (0..8).each do |n|
      dut.ahb.get_hsize(n).should == 0
    end
    (9..16).each do |n|
      dut.ahb.get_hsize(n).should == 1
    end
    (17..32).each do |n|
      dut.ahb.get_hsize(n).should == 2
    end
    (33..64).each do |n|
      dut.ahb.get_hsize(n).should == 3
    end
    (65..128).each do |n|
      dut.ahb.get_hsize(n).should == 4
    end
    (129..256).each do |n|
      dut.ahb.get_hsize(n).should == 5
    end
    (257..512).each do |n|
      dut.ahb.get_hsize(n).should == 6
    end
    (513..1024).each do |n|
      dut.ahb.get_hsize(n).should == 7
    end
  end

end
