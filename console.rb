require 'sequel'
require 'logger'

DB = Sequel.connect('postgres://postgres@localhost/playground')

DB.loggers << Logger.new($stdout)

binding.irb
