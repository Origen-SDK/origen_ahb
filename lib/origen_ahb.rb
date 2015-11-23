require 'rgen_testers'
require 'rgen'
require_relative '../config/application.rb'     
module OrigenAhb

  # Load all files in the lib directory via a wildcard, if your project becomes
  # large or load order dependencies start to creep in then you may need to
  # start taking control of this manually as described above.
  # Note that there is no problem from requiring a file twice (Ruby will ignore
  # the second require), so if you have a file that must be required up front
  # you can do that one manually and the let the wildcard take care of the rest.
  Dir.glob("#{File.dirname(__FILE__)}/**/*.rb").sort.each do |file| 
    require file
  end

  # Returns an instance of the OrigenAhb::Driver
  def ahb
    @OrigenAhb ||= Driver.new(self)
  end

end

# Add some aliases to handle common typos
#AHB = ahb

