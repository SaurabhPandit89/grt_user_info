module UserDetailHelper

  def display_tweets
    tweets = ''
    @tweets.each do |tweet|
      tweets << "#{tweet.user.screen_name} : #{tweet.text}" + tag('br')
    end
    tweets.html_safe
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
    if @rubygems_info.is_a?(String)
      content_tag(:i, @rubygems_info)
    else
      gems = ''
      @rubygems_info.each do |gem|
        gems << gem + tag('br')
      end
      gems.html_safe
    end
  end

end
