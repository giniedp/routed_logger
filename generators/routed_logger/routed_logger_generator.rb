class RoutedLoggerGenerator < Rails::Generator::NamedBase
  
  def initialize(runtime_args, runtime_options = {})
    super
    @name = runtime_args.shift
  end

  def manifest
    record do |m|
      m.directory "config/initializers"
      m.template "routed_logger.rb", File.join("config/initializers", "#{@name}.rb")
    end
  end

end
