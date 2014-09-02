class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization

  class NoOrganizationError < StandardError; end

  def organization_ldap_settings
    if organization
      organization.ldap_settings
    else
      raise NoOrganizationError
    end
  end

  def organization_requires_ldap?
    if organization
      organization.requires_ldap?
    else
      false
    end
  end
end
