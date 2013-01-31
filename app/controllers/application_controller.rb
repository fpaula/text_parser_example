require 'net/https'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def gem_info
    cache_key = 'gem-info'
    result = Rails.cache.read(cache_key)
    return result if result
    uri = URI.parse('https://rubygems.org/api/v1/gems/text_parser.json')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    result = nil
    p response.code
    if response.code == '200'
      result = JSON.parse(response.body)
      Rails.cache.write(cache_key, result, :expires_in => 50.seconds)
    end

    return result
  end
end
