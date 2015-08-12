require 'redmine'

require_dependency 'user'
User.send(:include, RedmineImpersonate::UserPatch)

require_dependency 'application_controller'
ApplicationController.send(:include, RedmineImpersonate::ApplicationControllerPatch)

Redmine::Plugin.register :redmine_impersonate do
  name 'Redmine Impersonate Plugin plugin'
  author 'Arkhitech'
  description 'Allows user to use redmine as another user and see what other user sees'
  version '1.0'
  url 'http://github.com/arkhitech/redmine_impersonate'
  author_url 'https://github.com/arkhitech'

  project_module :impersonate do
    permission :impersonate_project_user, impersonates: [:select_user, :start_impersonation, :stop_impersonation]

    menu :project_menu, :impersonates, 
      { controller: :impersonates, action: :select_user }, 
      after: :activity, param: :project_id
  end
end