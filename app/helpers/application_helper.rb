# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def logo
    logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  # Return a title on a per-page basis.
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end

  # The gravatar_for function does not seem to be defined
#  def gravatar_for email, options = {}
#    options = {:alt => 'avatar', :class => 'avatar', :size => 80}.merge! options
#    id = Digest::MD5::hexdigest email.strip.downcase
#    url = 'http://www.gravatar.com/avatar/' + id + '.jpg?s=' + options[:size].to_s
#    options.delete :size
#    image_tag url, options
#  end

end
