class AddRequiresLdapToOrganization < ActiveRecord::Migration
  def change
    add_column :organizations, :requires_ldap, :boolean
  end
end
