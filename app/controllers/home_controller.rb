class HomeController < ApplicationController
  def index
    @params = {:dictionary => "", :negative_dictionary => "", :order => "word", :order_direction => "asc"}
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
end
