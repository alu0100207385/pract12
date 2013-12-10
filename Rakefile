#!/bin/env rake
require "bundler/gem_tasks"

$:.unshift File.dirname(__FILE__) + 'lib'
$:.unshift './lib', './spec'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

desc "Ejecutar las espectativas de la clase Matriz e hijas"
task :spec_local do
  sh "rspec -I. spec/matrices_spec.rb"
end

desc "Ejecutar tests"
task :test do
  sh "ruby test/tc_matrices.rb"
end

desc "Ejecutar con documentacion"
task :doc do
  sh "rspec -I. spec/matrices_spec.rb --format documentation"
end

desc "Ejecutar programa"
task :bin do
  sh "ruby bin/main.rb"
end

desc "Ejecutar las espectativas de la clase Matriz version html"
task :thtml do
  sh "rspec -I. spec/matrices_spec.rb --format html"
end

desc "Ejecutar la clase Matriz version DSL"
task :dsl do
  sh "ruby lib/matricesDSL.rb"
end
