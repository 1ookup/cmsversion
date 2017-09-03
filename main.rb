$: << File.dirname(__FILE__)
#require 'cms_version'
require 'awesome_print'
require 'yaml'
require 'http'
require 'json'
require 'digest'
require 'fileutils'
require 'active_record'
require 'sqlite3'

require 'model/cms_name'
require 'model/cms_version'
require 'libs/base_cms'
require 'libs/github_cms'
require 'plugins/word_press'
require 'plugins/joomla'
require 'plugins/cms_easy'
require 'plugins/open_sns'
require 'plugins/drupal'
require 'plugins/metinfo'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database  => "cms_version.db")


# joomla = Joomla.new
# joomla.getNewVersion

# wp = WordPress.new
# wp.getNewVersion

#ce = CmsEasy.new
#ce.getNewVersion

#opensns = OpenSNS.new
#opensns.getNewVersion

# drupal = Drupal.new
# drupal.getNewVersion

metinfo = Metinfo.new
metinfo.getNewVersion