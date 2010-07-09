RoutedLogger.configuration do |settings|

  # the following are default values
  settings[:extension]       = "log"                  # logfile extension
  settings[:directory]       = Rails.root.join('log') # logfile directory
  settings[:shared_filename] = ""                     # logs are going to separate files
  settings[:log_time]        = true                   # timestamp is logged
  settings[:log_route]       = false                  # routename is not logged
  settings[:log_severity]    = true                   # severityname is logged

end