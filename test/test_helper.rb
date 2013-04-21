require 'minitest/autorun'
require 'minitest/english'

unless ENV['CI']
  require 'bond'
  require 'pry-awesome_print'
  require 'pry-coolline'
  require 'pry-debugger'
  require 'pry-rescue/minitest'
  require 'pry-stack_explorer'
end
