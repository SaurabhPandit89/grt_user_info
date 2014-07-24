# This module is created to keep the methods with VIEW's logic.
# Operation required to perform on the data before displaying
# on the VIEWS are kept in the methods defined here

# By doing this, it will keep the views simple.

module UserDetailHelper

  def display_tweets
    if @tweets.is_a?(String) || @tweets.blank?
      @tweets = @tweets.blank? ? 'No tweets found for user !!!' : @tweets
      content_tag(:i, @tweets)
    else
      tweets = ''
      @tweets.each { |tweet| tweets << "#{content_tag(:i, '@' + tweet.user.screen_name)} : #{tweet.text}" + tag('br') }
      tweets.html_safe
    end
  end

  def display_github_info
    if @github_info.is_a?(String)
      content_tag(:i, @github_info)
    else
      ("User Name : #{@github_info[:login]}" + tag('br') +
          "Date of Joining : #{@github_info[:created_at].to_date}" + tag('br') +
          "Public repositories : #{@github_info[:public_repos]}").html_safe
    end
  end

  def display_rubygems_info
    if @rubygems_info.is_a?(String) || @rubygems_info.blank?
      @rubygems_info = @rubygems_info.blank? ? 'No Gems found for user !!!' : @rubygems_info
      content_tag(:i, @rubygems_info)
    else
      gems = ''
      @rubygems_info.each { |gem| gems << gem + tag('br') }
      gems.html_safe
    end
  end

end
