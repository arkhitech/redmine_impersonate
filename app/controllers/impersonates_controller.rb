class ImpersonatesController < ApplicationController
  unloadable
  before_action :project, :permission!
  
  def permission!
    User.current.allowed_to?(:impersonate_project_user,project) || 
      User.current_without_impersonation.allowed_to?(:impersonate_project_user,project)
  end

  def select_user
    @users=@project.users
  end
  
  def start_impersonation
    user=User.find(params[:user][:impersonated_user_id])
    session[:impersonated_user_id]=params[:user][:impersonated_user_id]
    User.impersonated_user=user
    redirect_to action: 'select_user'
  end
  
  def stop_impersonation
    session[:impersonated_user_id] = User.impersonated_user = nil
    redirect_to action: 'select_user'
  end
  
  def project
    @project = Project.find(params[:project_id])
  end
  private :project
end