require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database  => "cms_version.db")


ActiveRecord::Schema.define do
  drop_table :cms_names if table_exists? :cms_names
  create_table :cms_names do |table|
    table.column :name, :string
  end
  drop_table :cms_versions if table_exists? :cms_versions
  create_table :cms_versions do |table|
    table.column :cms_name_id, :integer
    table.column :version, :string
    table.column :filename, :string
  end
end