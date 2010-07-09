# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = "routed_logger"
  s.version = "0.1.0"
  s.authors = ["RAlexander Gräfenstein"]
  s.email = ["alex@empuxa.com"]
  s.homepage = "http://empuxa.com"
  s.summary = "Logger module with the ability to log to different files/routes"
  s.description = "Logger module with the ability to log to different files/routes"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "routed_logger"

  s.files = Dir.glob("{generators,lib}/**/*") + %w(LICENSE README.md VERSION init.rb)
  s.require_path = 'lib'
end