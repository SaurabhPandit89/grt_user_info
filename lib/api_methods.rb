# This module contains the method related to API calls made to :
# 1. Github
# 2. Twitter
# 3. RubyGems

module APIMethods

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
    #get_repositories_name
  end

  def fetch_repositories
    unless @github_info.is_a?(String) || @github_info.blank?
      uri = URI.parse(@github_info[:repos_url])
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      http.use_ssl = true
      @response = begin
        http.request(request)
      rescue Exception => e
        e.message
      end
    end
  end

  def get_repositories_name
    fetch_repositories
    @repositories_name = []
    if @response.is_a?(Net::HTTPOK)
      repositories = JSON.parse(@response.body)
      repositories.each {|repository| @repositories_name << repository['name']}
    end
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
