class ApplicationController < ActionController::Base
  before_action :application

  def application
    @json_users = GithubService.users
    @commits = GithubService.commits
    @usable object in application.html.erb
  end
end
