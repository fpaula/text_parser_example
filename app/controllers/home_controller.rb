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
end
