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

when 'specs'
  require 'rspec'
  exit RSpec::Core::Runner.run(['spec'])


when 'examples', 'test'
  Origen.load_application
  status = 0

  # Pattern generator tests
  ARGV = %w(example -t dev -r approved)
  load "#{Origen.top}/lib/origen/commands/generate.rb"

  if Origen.app.stats.changed_files == 0 &&
     Origen.app.stats.new_files == 0 &&
     Origen.app.stats.changed_patterns == 0 &&
     Origen.app.stats.new_patterns == 0

    Origen.app.stats.report_pass
  else
    Origen.app.stats.report_fail
    status = 1
  end
  puts
  if @command == 'test'
    Origen.app.unload_target!
    require 'rspec'
    result = RSpec::Core::Runner.run(['spec'])
    status = status == 1 ? 1 : result
  end
  exit status  # Exit with a 1 on the event of a failure per std unix result codes

# Always leave an else clause to allow control to fall back through to the
# RGen command handler.
else
  @application_commands = <<-EOT
 specs        Run the specs (tests), -c will enable coverage
 examples     Run the examples (tests), -c will enable coverage
 test         Run both specs and examples, -c will enable coverage
  EOT

end
