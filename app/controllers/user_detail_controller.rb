# Following controller contains the methods to fetch and export the user details
# from following websites :
# 1. Twitter
# 2. Github
# 3. RubyGem

# This controller only contains three actions :
# 1. new : used just to render the home/root page.
# 2. details : used to fetch details form 3 websites and display it on view.
# 3. export : used to export the data displayed by the details action to PDF/DOC.
# Rest of the methods are private methods, they will be used by the above actions internally.

class UserDetailController < ApplicationController

  before_filter :set_user_name, :except => [:new]

  def new
  end

  # Method to fetch & Display User infos
  def details
    fetch_infos
  end

  # Method to export HTML to PDF & DOC
  def export
    fetch_infos
    mime_type = params[:mime_type]
    html = render_to_string(:action => :export, :layout => 'export.html.erb')
    data = mime_type == 'pdf' ? WickedPdf.new.pdf_from_string(html) : html
    send_data(data,
              :filename    => "#{@user_name}.#{mime_type}",
              :disposition => 'attachment')
  end

  # Methods defined here as private are only for internal use

  private

  # Creates a twitter client to communicate with Twitter API gem
  def twitter_client_config
    Twitter::REST::Client.new do |config|
      config.consumer_key    = 'VxIibKGbLjn8pPMm7R5XPB3Iu'
      config.consumer_secret = 'TWhxcssR8Sp8UAOB6vEduTToPpOuVowgpSMqxYABubrnBVrm0O'
    end
  end

  # Fetches tweets from the user time line
  def tweets
    @tweets = begin
      client = twitter_client_config
      client.user_timeline(@user_name, {:count => 10})
    rescue Exception => e
      'Twitter account not found !!!'
    end
  end

  # Fetches Github info
  # Github provides following information about the users :
  # 1. Date of Joining
  # 2. Number of public repositories
  # 3. Name of all the public repositories

  def github_info
    @github_info = begin
      Octokit.user @user_name
    rescue Exception => e
      'Github account information not found !!!'
    end
  end

  # Fetches details for gems created by user
  # RubyGems provides following information about the users:
  # 1. Name of all the Gems created by the user

  def rubygems_info
    @rubygems_info = begin
      Gems.gems(@user_name).collect!{|gem| "#{gem['name']} ~> #{gem['version']}"}
    rescue Exception => e
      'Rubygems.org account information not found !!!'
    end
  end

  # Fetches combined information from Twitter, Github & RubyGems
  def fetch_infos
    tweets
    github_info
    rubygems_info
  end

  # filter to set user name
  def set_user_name
    @user_name = params[:user_name]
  end

end
