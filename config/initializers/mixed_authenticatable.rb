require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class MixedAuthenticatable < Authenticatable
      def authenticate! 
        authenticator.authenticate!
      end

      private

      def authenticator
        authenticator_factory.new(@env, @scope)
      end

      def authenticator_factory
        if user_requires_ldap_authentication
          LdapAuthenticatable
        else
          DatabaseAuthenticatable
        end
      end

      def user_requires_ldap_authentication
        if user = User.find_by_email(email)
          user.organization_requires_ldap?
        else
          false
        end
      end

      def email
        user_params[:email]
      end

      def user_params
        params[:user]
      end
    end
  end
end

Warden::Strategies.add(:mixed_authenticatable, Devise::Strategies::MixedAuthenticatable)