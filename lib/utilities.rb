module Utilities
  def process_params(params)
    params.delete_if{|k,v| v.blank? || v == [] || v.nil?}
    params = params.symbolize_keys
    options = {}
    options.merge!(:dictionary => params[:dictionary].split(",").each{|w| w.strip!}) if params[:dictionary]
    options.merge!(:negative_dictionary => params[:negative_dictionary].split(",").each{|w| w.strip!}) if params[:negative_dictionary] 
    options.merge!(:order => params[:order].to_sym) if params[:order]
    options.merge!(:order_direction => params[:order_direction].to_sym) if params[:order_direction]
    options.merge!(:minimum_length => params[:minimum_length].to_i) if params[:minimum_length] 
    @options = options
  end
end