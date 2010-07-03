#[HOST]
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://inherit.iwakela.com"

SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add path, options
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly', 
  #           :lastmod => Time.now, :host => default_host

  # Examples:
  
  # add '/'
  sitemap.add root_path, :priority => 0.9

  # add '/home'
  sitemap.add home_path, :priority => 0.7, :changefreq => 'daily'

  # add '/questions'
  sitemap.add questions_path, :priority => 0.7, :changefreq => 'daily'
  
  # add all individual use
  User.find_in_batches(:batch_size => 1000) do |users|
    users.each do |u|
      sitemap.add user_home_path(u.username), :priority => 0.7, :changefreq => 'daily'
    end
  end

  # add all individual experience
  Experience.find_in_batches(:batch_size => 1000) do |experiences|
    experiences.each do |e|
      sitemap.add experience_path(e), :lastmod => e.updated_at
    end
  end

  # add all individual goal
  Goal.find_in_batches(:batch_size => 1000) do |goals|
    goals.each do |g|
      sitemap.add goal_path(g), :lastmod => g.updated_at
    end
  end

  # add all individual question
  Question.find_in_batches(:batch_size => 1000) do |questions|
    questions.each do |q|
      sitemap.add question_path(q), :lastmod => q.updated_at
    end
  end

  # add merchant path
  #sitemap.add '/purchase', :priority => 0.7
  
end

# Including Sitemaps from Rails Engines.
#
# These Sitemaps should be almost identical to a regular Sitemap file except 
# they needn't define their own SitemapGenerator::Sitemap.default_host since
# they will undoubtedly share the host name of the application they belong to.
#
# As an example, say we have a Rails Engine in vendor/plugins/cadability_client
# We can include its Sitemap here as follows:
# 
# file = File.join(Rails.root, 'vendor/plugins/cadability_client/config/sitemap.rb')
# eval(open(file).read, binding, file)
