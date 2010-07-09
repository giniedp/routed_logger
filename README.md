RoutedLogger
=====================================================
With RoutedLogger you can log information to different files. Lets say you
you want to track different events of your application inside different logfiles.
In this case, RoutedLogger is what you need.

Installation
=====
RoutedLogger has to be installed as a plugin located under vendor/plugins

    $ cd RAILS_ROOT && ./script/plugin install git@github.com:giniedp/routed_logger.git

Usage
=====
Log everywhere in your application like this :

    RoutedLogger.foo.info "bar"
    
The message *bar* with the severity *info* will be logged to the the route *foo*.
Assuming your app is running in development environment using default RoutedLogger 
settings this will generate the following line :

    [<timestamp>] [info] bar
    
inside a logfile located in :

    path_to_your_app/log/foo_development.log
    
Customization
=====    
To generate an initializer run this command :

    script/generate routed_logger routed_logger_init

This command will generate a file located in *config/initializers/routed_logger_init.rb*
with the following content :

    RoutedLogger.configuration do |settings|
    
      # the following are default values
      settings[:extension]       = "log"                  # logfile extension
      settings[:directory]       = Rails.root.join('log') # logfile directory
      settings[:shared_filename] = ""                     # logs are going to separate files
      settings[:log_time]        = true                   # timestamp is logged
      settings[:log_route]       = false                  # routename is not logged
      settings[:log_severity]    = true                   # severityname is logged
    
    end

All settings are self-explanatory except the *shared_filename* setting.
If this is set, all logs are written to a single file with the name of this setting. 
You may set it to 'Rails.env' for example to log everything to your current 
environment log e.g. *development.log*