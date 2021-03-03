class ApplicationController < ActionController::Base
  before_action :application

  def application
    @json_users = GithubService.users
  end
end
