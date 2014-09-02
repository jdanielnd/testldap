class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :ldap_settings

      t.timestamps
    end
  end
end
