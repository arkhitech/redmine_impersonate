redmine_impersonate
===================

Allows people with permission to impersonate user's in their project where the module is activated and allows administrator to impersonate anyone.  This is helpful in setting up roles and permissions for redmine.


Installation:
-------------

- To install plugin, go to plugins folder of your Redmine repository and run:

        git clone http://github.com/arkhitech/redmine_impersonate

- Run db migrations for the plugin

        rake redmine:plugins:migrate RAILS_ENV=production

- Bundle install all the gems using the following command

        bundle install


- After installation, log in to Redmine as administrator and go to plugin settings for Redmine impersonate plugin configuration.


