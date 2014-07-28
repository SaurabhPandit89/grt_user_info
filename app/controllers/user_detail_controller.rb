# Following controller contains the methods to fetch and export the user details
# from following websites :
# 1. Twitter
# 2. Github
# 3. RubyGem

# This controller only contains three actions :
# 1. new : used just to render the home/root page.
# 2. details : used to fetch details form 3 websites and display it on view.
# 3. export : used to export the data displayed by the details action to PDF/DOC.

require './lib/api_methods'
require './lib/pdf'

class UserDetailController < ApplicationController

  include APIMethods
  include PDF

  before_filter :set_user_name, :except => [:new]

  def new
  end

  # Method to fetch & Display User infos
  def details
    fetch_infos #called from lib/api_methods.rb:64
  end

  # Method to export HTML to PDF & DOC
  def export
    fetch_infos #called from lib/api_methods.rb:64
    mime_type = params[:mime_type]
    html = render_to_string(:action => :export, :layout => 'export.html.erb')
    data = mime_type == 'pdf' ? render_to_pdf(html) : html  #render_to_pdf called from lib/pdf.rb:6
    send_data(data,
              :filename    => "#{@user_name}.#{mime_type}",
              :disposition => 'attachment')
  end

  # Methods defined here as private and are only for internal use

  private

  # filter to set user name
  def set_user_name
    @user_name = params[:user_name]
  end

end
