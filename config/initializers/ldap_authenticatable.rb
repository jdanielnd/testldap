require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        if params[:user]
          ldap = Net::LDAP.new
          domain = User.find_by_email(email).organization_ldap_settings
          dn = "cn=#{email},#{domain}"
          ldap.auth dn, password

          if ldap.bind and user = User.find_by_email(email)
            user.update_attribute(:password, password)
            success!(user)
          else
            fail(:invalid_login)
          end
        end
      end

      def email
        params[:user][:email]
      end

      def password
        params[:user][:password]
      end

    end
  end
end
