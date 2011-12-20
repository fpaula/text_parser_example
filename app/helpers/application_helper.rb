module ApplicationHelper
  def select_minimum_length_tag
    options = "<option value=''>Doesn't matter the words' minimum lenght</option>"
    2.upto(10) do |i|
      selected = @params[:minimum_length] == i.to_s ? " selected='selected'" : ""
      options << "<option value='#{i}'#{selected}>Only words with at least #{i} characters</option>"
    end
    select_tag "minimum_length", options.html_safe
  end
end
