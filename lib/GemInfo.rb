require 'net/https'
require 'uri'
require 'json'

class GemInfo
  def self.get    
    uri = URI.parse('https://rubygems.org/api/v1/gems/text_parser.json')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    JSON.parse(response.body)
  end
end