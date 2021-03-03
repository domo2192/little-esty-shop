class ApplicationController < ActionController::Base
  before_action :application

  def application
    @prs = GithubService.prs
  end
end
