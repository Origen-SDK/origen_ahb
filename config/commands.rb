# This file should be used to extend the rgen command line tool with tasks 
# specific to your application.
# The comments below should help to get started and you can also refer to
# lib/rgen/commands.rb in your RGen core workspace for more examples and 
# inspiration.
#
# Also see the official docs on adding commands:
#   http://rgen.freescale.net/rgen/latest/guides/custom/commands/

# Map any command aliases here, for example to allow 'rgen ex' to refer to a 
# command called execute you would add a reference as shown below: 
aliases ={
#  "ex" => "execute",
}

# The requested command is passed in here as @command, this checks it against
# the above alias table and should not be removed.
@command = aliases[@command] || @command

# Now branch to the specific task code
case @command

# Here is an example of how to implement a command, the logic can go straight
# in here or you can require an external file if preferred.
when "my_command"
  puts "Doing something..."
  require "commands/my_command"    # Would load file lib/commands/my_command.rb
  # You must always exit upon successfully capturing a command to prevent 
  # control flowing back to RGen
  exit 0

## Example of how to make a command to run unit tests, this simply invokes RSpec on
## the spec directory
#when "specs"
#  ARGV.unshift "spec"
#  require "rspec"
#  require "rspec/autorun"
#  exit 0 # This will never be hit on a fail, RSpec will automatically exit 1

## Example of how to make a command to run diff-based tests
when "examples"  
#  RGen.load_application
  status = 0
#
#  # Compiler tests
#  ARGV = %w(templates/example.txt.erb -t debug -r approved)
#  load "rgen/commands/compile.rb"
#  # Pattern generator tests
#  #ARGV = %w(some_pattern -t debug -r approved)
#  #load "#{RGen.top}/lib/rgen/commands/generate.rb"
#
#  if RGen.app.stats.changed_files == 0 &&
#     RGen.app.stats.new_files == 0 &&
#     RGen.app.stats.changed_patterns == 0 &&
#     RGen.app.stats.new_patterns == 0
#
#    RGen.app.stats.report_pass
#  else
#    RGen.app.stats.report_fail
#    status = 1
#  end
#  puts
  exit status  # Exit with a 1 on the event of a failure per std unix result codes

# Always leave an else clause to allow control to fall back through to the
# RGen command handler.
else
  # You probably want to also add the your commands to the help shown via
  # rgen -h, you can do this be assigning the required text to @application_commands
  # before handing control back to RGen. Un-comment the example below to get started.
#  @application_commands = <<-EOT
# specs        Run the specs (tests), -c will enable coverage
# examples     Run the examples (tests), -c will enable coverage
#  EOT

end 
