class UserDetailController < ApplicationController

  before_filter :set_user_name, :except => [:new]

  def new
  end

  def details
    fetch_infos
  end

  def export
    fetch_infos
    mime_type = params[:mime_type]
    html = render_to_string(:action => :export, :layout => 'export.html.erb')
    data = mime_type == 'pdf' ? WickedPdf.new.pdf_from_string(html) : html
    send_data(data,
              :filename    => "#{@user_name}.#{mime_type}",
              :disposition => 'attachment')
  end

  private

  def twitter_client_config
    Twitter::REST::Client.new do |config|
      config.consumer_key    = 'VxIibKGbLjn8pPMm7R5XPB3Iu'
      config.consumer_secret = 'TWhxcssR8Sp8UAOB6vEduTToPpOuVowgpSMqxYABubrnBVrm0O'
    end
  end

  def tweets
    @tweets = begin
      client = twitter_client_config
      client.user_timeline(@user_name, {:count => 10})
    rescue Exception => e
      'No tweets found for user !!!'
    end
  end

  def github_info
    @github_info = begin
      Octokit.user @user_name
    rescue Exception => e
      'Github account information not found !!!'
    end
  end

  def rubygems_info
    @rubygems_info = begin
      Gems.gems(@user_name).collect!{|gem| "#{gem['name']} ~> #{gem['version']}"}
    rescue Exception => e
      'Rubygems.org account information not found !!!'
    end
  end

  def fetch_infos
    tweets
    github_info
    rubygems_info
  end

  def set_user_name
    @user_name = params[:user_name]
  end

end
