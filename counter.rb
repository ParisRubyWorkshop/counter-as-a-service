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

  put '/:counter_name/incr' do
    sleep 1 # For educational purposes, this shows users of the api that api responses can be slow
    {
      name: params["counter_name"],
      value: redis.incr(params["counter_name"])
    }.to_json
  end

  put '/:counter_name/decr' do
    sleep 1 # For educational purposes, this shows users of the api that api responses can be slow
    {
      name: params["counter_name"],
      value: redis.decr(params["counter_name"])
    }.to_json
  end

  def redis
    Redis.new(url: ENV['REDIS_URL'])
  end

end

