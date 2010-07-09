require 'active_support'

module RoutedLogger
  LOG_SETTINGS = {
    :extension => "log",
    :directory => Rails.root.join('log'),
    :shared_filename => "",
    :log_time => true,
    :log_route => false,
    :log_severity => true
  }
  LOG_INSTANCES = {}
  
  def self.configuration
    yield(LOG_SETTINGS)
  end
  
  def self.method_missing(name, *args)
    return RoutedLogger.get_logger(name)
  end

  def self.get_logger(route)
    RoutedLogger.add_route(route) unless RoutedLogger.has_route?(route)
    LOG_INSTANCES[route.to_s]
  end
  
  def self.get_route(route)
    RoutedLogger::LOG_INSTANCES[route.to_s]
  end
  
  def self.has_route?(route)
    !RoutedLogger.get_route(route).nil?
  end
  
  def self.add_route(route)
    return RoutedLogger.get_route(route) if(RoutedLogger.has_route?(route))
    
    if LOG_SETTINGS[:shared_filename].blank?
      filename = File.join(LOG_SETTINGS[:directory], "#{route}_#{Rails.env}.#{LOG_SETTINGS[:extension]}")
    else
      filename = File.join(LOG_SETTINGS[:directory], "#{LOG_SETTINGS[:shared_filename]}.#{LOG_SETTINGS[:extension]}")
    end
    
    LOG_INSTANCES[route.to_s] = RoutedLogger::Base.new(filename, route)
  end
  
  def self.remove_route(route)
    LOG_INSTANCES[route.to_s] = nil
  end
  
  class Base < ActiveSupport::BufferedLogger
    @route = ""
    SEVERITY_NAME = %w( DEBUG INFO WARN ERROR FATAL UNKNOWN )
    
    def initialize(filename, route)
      super(filename)
      @route = route
    end
    
    def custom_line(severity, message)
      result = ""
      result << "[#{Time.now.to_s(:db)}] "      if RoutedLogger::LOG_SETTINGS[:log_time]
      result << "[#{@route}] "                  if RoutedLogger::LOG_SETTINGS[:log_route]
      result << "[#{SEVERITY_NAME[severity]}] " if RoutedLogger::LOG_SETTINGS[:log_severity]
      result << message
      message = result
    end
    
    def add(severity, message = nil, progname = nil, &block)
      return if @level > severity
      message = (message || (block && block.call) || progname).to_s
      # If a newline is necessary then create a new message ending with a newline.
      # Ensures that the original message is not mutated.
      message = "#{message}\n" unless message[-1] == ?\n
      message = custom_line(severity, message) # <== CUSTOMIZED
      buffer << message
      auto_flush
      message
    end
  end

end