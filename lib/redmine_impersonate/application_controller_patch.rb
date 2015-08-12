module RedmineImpersonate
  module ApplicationControllerPatch
    def self.included(base)
      base.class_eval do
        unloadable
        
        before_action :impersonate_if_needed
        alias_method :logout_user_without_impersonate, :logout_user

        def impersonate_if_needed
          if session[:impersonated_user_id]
            User.impersonated_user=User.find(session[:impersonated_user_id])          
          end
        end
        def logout_user
          session[:impersonated_user_id] = User.impersonated_user = nil
          logout_user_without_impersonate
        end
        
      end
    end    
  end
end