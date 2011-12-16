require 'net/https'
require 'uri'
require 'json'

class HomeController < ApplicationController
  def index
    @params = {:dictionary => "", :negative_dictionary => "", :order => "word", :order_direction => "asc"}
    @gem_info = gem_info
    unless params[:text].blank?      
      @options = { :dictionary           => !params.fetch(:dictionary, "").blank? ? params[:dictionary].split(",").each{|w| w.strip!} : nil,
                   :negative_dictionary  => !params.fetch(:negative_dictionary, "").blank? ? params[:negative_dictionary].split(",").each{|w| w.strip!} : nil,
                   :order                => params[:order] ? params[:order].to_sym : nil,
                   :order_direction      => params[:order_direction] ? params[:order_direction].to_sym : nil }
      puts @options.inspect             
      @parsed_text = params[:text].parse(@options)
      @params = params
    end
  end
  
  private
  
  def gem_info   
    cache_key = 'gem-info'
    result = Rails.cache.read(cache_key)
    return result if result
    puts 'nao pegou cache'
    uri = URI.parse('https://rubygems.org/api/v1/gems/text_parser.json')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    result = JSON.parse(response.body)
    Rails.cache.write(cache_key, result, :expires_in=>30.seconds)
    return result
  end
end
