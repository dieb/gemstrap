require 'pathname'
require 'fileutils'

require 'gemstrap/template'

module Gemstrap
  class CLI
    include FileUtils

    def self.read
      {}
    end

    def self.run(options)
      self.new(options).run
    end

    def initialize(options)
      #@options = options
      context
    end

    def run
      create_directories
      generate_gemspec
    rescue => e
      puts e.message
      puts e.backtrace.join("\n")
      puts 'Rolling back'
      rm_rf path
    end

    def method_missing(method, *args, &block)
      return context[method] if context.include?(method)
      super
    end

    private

    def options
      @options ||= {
        gem_name: 'foo',
        authors: [],
        authors_emails: [],
        description: '',
        summary_or_description: '',
      }
    end

    def context
      options[:templates] = Pathname.new(File.dirname(__FILE__)).join('template')
      options[:path]      = Pathname.new('.').join(options[:gem_name])
      options[:lib_path]  = options[:path].join('lib')
      options[:spec_path] = options[:path].join('spec')
      options[:gem_module] = options[:gem_name].split('-').map { |n| n.split('_') }.flatten.map(&:capitalize).join
      options
    end

    def create_directories
      mkdir_p lib_path
      mkdir   spec_path
      cp      templates.join('Rakefile'), path
    end

    def generate_gemspec
      gemspec = Gemstrap::Template.render(templates.join('gemspec.erb'), context)
      IO.write(path.join("#{gem_name}.gemspec"), gemspec)
    end
  end
end