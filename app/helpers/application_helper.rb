# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def format_email(email)
    %Q[<a href="mailto:#{email}?subject=CLTP - ">#{email}</a>]
   # "mailto:#{email}?subject=CLTP - ">#{email}
  end
end
