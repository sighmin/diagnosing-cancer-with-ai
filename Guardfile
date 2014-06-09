# Continuous local dev testing tool setup

notification :tmux,
  display_message: true,
  timeout: 3,
  default_message_format: ' %s >> %s',
  line_separator: ' > '

guard :rspec, cmd: 'bundle exec rspec --color --format doc' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})          { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
  watch('spec/spec_helper.rb')       { "spec" }
end

# Use this to watch a executable file in bin/
# guard :rspec, cmd: 'bundle exec ruby bin/run' do
#   watch(/.*/)
#   watch('bin/run')
# end
