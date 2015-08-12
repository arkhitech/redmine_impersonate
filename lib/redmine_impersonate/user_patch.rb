module RedmineImpersonate
  module UserPatch
    def self.included(base)

      base.class_eval do
        unloadable
        class << self
          alias_method :current_without_impersonation, :current
          def current
            Thread.current[:impersonated_user] || current_without_impersonation
          end
          def impersonated_user=(user)
            Thread.current[:impersonated_user]=user
          end
          def impersonated_user
            Thread.current[:impersonated_user]
          end
        end

        alias_method :allowed_to_without_impersonation?, :allowed_to?
        def allowed_to?(action, context, options={}, &block)
          if action=={controller: :impersonates, action: :select_user}
            User.current_without_impersonation.allowed_to_without_impersonation?(action, context, options, &block)
          else
            allowed_to_without_impersonation?(action, context, options, &block)
          end
        end
      end        
    end    
  end
end