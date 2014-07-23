class UserDetailController < ApplicationController

  before_filter :set_user_name

  def new
  end

  def details
    tweets
    github_info
    rubygems_info
  end

  private

  def twitter_client_config
    Twitter::REST::Client.new do |config|
      config.consumer_key    = '<consumer_key>'
      config.consumer_secret = '<consumer_secret>'
    end
  end

  def tweets
    client = twitter_client_config
    @tweets = client.user_timeline(@user_name, {:count => 10})
    if @tweets.blank?
      ['No tweets found for user']
    else
      @tweets
    end
  end

  def github_info
    @github_info = begin
      Octokit.user @user_name
    rescue Exception => e
      puts e.message
      'Github account information not found !!!'
    end
  end

  def rubygems_info
    @rubygems_info = begin
      Gems.gems(@user_name).collect!{|gem| "#{gem['name']} ~> #{gem['version']}"}
    rescue Exception => e
      puts e.message
      'Rubygems.org account information not found !!!'
    end
  end

  def set_user_name
    @user_name = params[:user_name]
  end

end
