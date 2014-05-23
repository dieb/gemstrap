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
      copy_gitignore
      copy_rakefile
      copy_gemfile
      generate_readme
      generate_gemspec
      mkdir_p(lib_path)
      mkdir_p(lib_path.join(gem_name))
      generate_lib_files
      mkdir_p(spec_path)
      cp(templates.join('Rakefile'), path)
    end

    def mkdir_p(path)
      say_created(path)
      super(path)
    end

    def copy_gitignore
      copy_template(templates.join('gitignore'), path.join('.gitignore'))
    end

    def copy_rakefile
      copy_template(templates.join('Rakefile'), path.join('Rakefile'))
    end

    def copy_gemfile
      copy_template(templates.join('Gemfile'), path.join('Gemfile'))
    end

    def generate_readme
      generate_file(path.join('README.md'), render_template('README.md.erb'))
    end

    def generate_gemspec
      generate_file(path.join("#{gem_name}.gemspec"), render_template('gemspec.erb'))
    end

    def generate_lib_files
      generate_file(lib_path.join("#{gem_name}.rb"), render_template('lib/root.rb.erb'))
      generate_file(lib_path.join("#{gem_name}/version.rb"), render_template('lib/gem_name/version.rb.erb'))
    end

    def render_template(template_path)
      Gemstrap::Template.render(templates.join(template_path), context)
    end

    def copy_template(from, to)
      cp(from, to)
      say_created(to)
    end

    def generate_file(path, contents)
      IO.write(path, contents)
      say_created(path)
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