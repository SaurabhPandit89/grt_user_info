# This module contains the method related to API calls made to :
# 1. Github
# 2. Twitter
# 3. RubyGems

require './lib/fetch_repositories'

module APIMethods

  include FetchRepositories

  # Creates a twitter client to communicate with Twitter API gem
  def twitter_client_config
    Twitter::REST::Client.new do |config|
      config.consumer_key    = TWITTER_KEYS[:consumer_key]
      config.consumer_secret = TWITTER_KEYS[:consumer_secret]
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
  # 2. Name of all the public repositories.

  def github_info
    @github_info = begin
      Octokit.user @user_name
    rescue Exception => e
      'Github account information not found !!!'
    end
    get_repositories_name unless @github_info.is_a?(String)
  end

  def get_repositories_name
    repositories = get_repositories(@github_info[:repos_url])  #called from lib/fetch_repositories.rb:3
    @repositories_name = []
    repositories.each {|repository| @repositories_name << repository['name']} unless repositories.blank?
    @repositories_name
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

end
