require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'logger'
require 'json'

DB = Sequel.connect('postgres://postgres@localhost/playground')

DB.loggers << Logger.new($stdout)

get '/' do
  potions = DB[:potions].order(:id).all
  json(potions)
end
