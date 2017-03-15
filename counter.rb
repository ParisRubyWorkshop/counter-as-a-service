require 'bundler/setup'
require 'sinatra/base'
require 'redis'

class Counter < Sinatra::Base

	get '/:counter_name' do
    {
      name: params["counter_name"],
      value: redis.get(params["counter_name"]) || 0
    }.to_json
	end

  post '/:counter_name/increment' do
    {
      value: redis.incr(params["counter_name"])
    }
  end

  post '/:counter_name/decrement' do
    {
      value: redis.decr(params["counter_name"])
    }
  end

  def redis
    Redis.new(url: ENV['REDIS_URL'])
  end

end

