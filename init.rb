require 'redmine'

require_dependency 'user'
class User < Principal
  class << self
    alias_method :current_without_impersonation, :current
    def current
      RequestStore.store[:impersonated_user] || current_without_impersonation
    end
    def impersonated_user=(user)
      RequestStore.store[:impersonated_user]=user
    end
    def impersonated_user
      RequestStore.store[:impersonated_user]
    end
  end
  alias_method :allowed_to_without_impersonation?, :allowed_to?
  def allowed_to?(action, context, options={}, &block)
    if (action=={:controller=>:impersonate, :action=>"select_user"} || action==:impersonate_project_user)
      User.current_without_impersonation.allowed_to_without_impersonation?(action, context, options, &block)
    else
      allowed_to_without_impersonation?(action, context, options, &block)
    end
  end

end
require_dependency 'application_controller'
class ApplicationController < ActionController::Base
  unloadable
  before_filter :impersonate_if_needed
  def impersonate_if_needed
    if session[:impersonated_user_id]
      User.impersonated_user=User.find(session[:impersonated_user_id])
    end
  end
  alias_method :logout_user_without_impersonate, :logout_user
  def logout_user
    session[:impersonated_user_id] = User.impersonated_user = nil
    logout_user_without_impersonate
  end
end

Redmine::Plugin.register :redmine_impersonate do
  name 'Redmine Impersonate Plugin plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'

  project_module :impersonate do
    permission :impersonate_project_user,:impersonate => [:select_user, :start_impersonation, :stop_impersonation]

    menu :project_menu, :impersonate,
      { controller: :impersonate, :action => 'select_user' },
      after: :activity, param: :project_id
  end
end
