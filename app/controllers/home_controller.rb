require ::File.expand_path('../../../lib/utilities',  __FILE__)

class HomeController < ApplicationController
  include Utilities
  
  def index
    process_params(params)
    @gem_info = gem_info
    unless params[:text].blank?      
      @parsed_text = params[:text].parse(@options)
    end
  end
end
