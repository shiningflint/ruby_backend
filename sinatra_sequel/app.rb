require 'dotenv'
require 'sinatra'
require 'sinatra/json'
require 'sequel'
require 'logger'
require 'json'

ENV = Dotenv.load

DB = Sequel.connect(
  adapter: 'postgres',
  host: ENV['DB_HOST'],
  database: ENV['DB'],
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD']
)

DB.loggers << Logger.new($stdout)

get '/' do
  potions = DB[:potions].order(:id).all
  json(potions)
end

post '/potions' do
  DB[:potions].insert(params)
  json('success')
end

post '/books' do
  DB[:books].insert(params)
  json('success')
end
