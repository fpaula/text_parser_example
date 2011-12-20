require 'net/https'
require 'uri'
require 'json'

class HomeController < ApplicationController
  def index
    @params = {:dictionary => "", :negative_dictionary => "", :order => "word", :order_direction => "asc"}
    @gem_info = gem_info
    unless params[:text].blank?      
      @options = { :dictionary           => params[:dictionary].split(",").each{|w| w.strip!},
                   :negative_dictionary  => params[:negative_dictionary].split(",").each{|w| w.strip!},
                   :order                => params[:order].to_sym,
                   :order_direction      => params[:order_direction].to_sym,
                   :minimum_length       => params[:minimum_length].to_i }
      @options.delete_if{|k,v| v.nil? || v == []}
      @parsed_text = params[:text].parse(@options)
      @params = params
    end
  end
  
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
    result = JSON.parse(response.body)
    Rails.cache.write(cache_key, result, :expires_in => 50.seconds)
    return result
  end
end
