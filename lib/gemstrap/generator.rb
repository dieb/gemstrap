require 'pathname'
require 'fileutils'
require 'gemstrap/template'


module Gemstrap
  class Generator
    include FileUtils

    CLEAR   = "\e[0m"
    BOLD    = "\e[1m"
    BLACK   = "\e[30m"
    RED     = "\e[31m"
    GREEN   = "\e[32m"
    YELLOW  = "\e[33m"
    BLUE    = "\e[34m"
    MAGENTA = "\e[35m"
    CYAN    = "\e[36m"
    WHITE   = "\e[37m"

    def run(args)
      options.merge!(args)
      puts "   creating gem #{color(gem_name, YELLOW)}"
      say_args(args)
      generate!
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
        gem_name: '',
        authors: [],
        authors_emails: [],
        description: '',
        summary: '',
        github_user: '',
        homepage: ''
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

    def generate!
      puts "   generate"
      mkdir_p(path)
      generate_gemspec
      mkdir_p(lib_path)
      mkdir_p(spec_path)
      cp(templates.join('Rakefile'), path)
    end

    def mkdir_p(path)
      say_created(path)
      super(path)
    end

    def generate_gemspec
      gemspec = Gemstrap::Template.render(templates.join('gemspec.erb'), context)
      file = path.join("#{gem_name}.gemspec")
      IO.write(file, gemspec)
      say_created(file)
    end

    def say_args(args)
      puts "   gem data"
      args.each do |k, v|
        k = color(k, BOLD, true)
        puts "     using   #{k.ljust(28)} => #{v}"
      end
    end

    def say_created(item)
      created_color = color('create', GREEN, true)
      puts "     #{created_color}  #{item.to_s}"
    end

    def color(text, color, bold=false)
      bold  = bold ? BOLD : ""
      "#{bold}#{color}#{text}#{CLEAR}"
    end
  end
end