require 'utilities'
require 'json'

class Api < Sinatra::Base
  include Utilities
  post "/*" do
    process_params(params)
    content_type :json
    if params[:text]
      params[:text].parse(@options).to_json
    else
      status 500
      {:error=>"Text is required"}.to_json
    end
  end
  get "/*" do
    content_type :json
    status 404
    {:error=>"Use method POST"}.to_json
  end
end
