require 'optparse'
require 'gemstrap/version'
require 'gemstrap/generator'
require 'term/ansicolor'

module Gemstrap
  class CLI
    extend Term::ANSIColor

    def self.read(arguments = ARGV)
      options = Hash.new
      optparse = OptionParser.new do |opts|
        opts.on('-h', '--help', 'Display this message') do
          puts opts
          exit
        end
        opts.on('-V', '--version', 'Display version') do
          puts Gemstrap::VERSION
          exit
        end
        opts.on('-n', '--name GEM_NAME', 'Gem name') do |gem_name|
          options[:gem_name] = gem_name
        end
        opts.on('-d', '--description GEM_DESC', 'Gem description') do |description|
          options[:description] = description
        end
        opts.on('-a', '--authors AUTHORS', 'CSV list of authors names (e.g. John Dorian, Christopher Turk)') do |authors|
          options[:authors] = authors.split(',')
        end
        opts.on('-m', '--emails AUTHORS_EMAILS', 'CSV list of corresponding authors emails (e.g. jd@sacredheart.com, turk@sacredheart.com)') do |authors_emails|
          options[:authors_emails] = authors_emails.split(',')
        end
        opts.on('-s', '--summary SUMMARY', 'Gem summary. If not supplied takes description value.') do |summary|
          options[:summary] = summary
        end
        opts.on('-g', '--github_user GITHUB_USER', 'Github user. If not blank, homepage will be set to GITHUB_USER/GEM_NAME') do |github_user|
          options[:github_user] = github_user
        end
        opts.on('-H', '--homepage HOMEPAGE', 'Homepage URL. Takes priority over the github_user parameter.') do |homepage|
          options[:homepage] = homepage
        end
        opts.on('-i', '--interactive', 'Interactive mode. Prompt for user the parameters for gem generate.') do
          options = run_interactive_mode
        end
      end
      optparse.parse!(arguments)
      options = run_interactive_mode if options.empty?
      fail('error: gem name cannot be empty') if options[:gem_name].size == 0
      options[:homepage] = "https://github.com/#{options[:github_user]}/#{options[:gem_name]}" if options[:homepage].size == 0
      options[:summary] ||= options[:description]
      options
    end

    def self.run_interactive_mode
      options = Hash.new
      puts "gemstrap: starting interactive mode"
      puts 'gemstrap: please type in the required fields:'
      options[:gem_name] = prompt('  gem name: ')

      unless `which git`.empty?
        git_name = `git config --global --get user.name`.strip
        git_email = `git config --global --get user.email`.strip
        git_author = "#{git_name} <#{git_email}>"
        author = prompt("  author (press enter to autofill with #{git_author}): ")
        if author.empty?
          options[:authors] = [git_name]
          options[:authors_emails] = [git_email]
        else
          options[:authors] = [author.split(' <').first]
          options[:authors_emails] = [author.split(' <').last[0..-2]]
        end
      else
        options[:authors] = [prompt('  author: ')]
        options[:authors_emails] = [prompt('  author email: ')]
      end

      puts 'gemstrap: please type in the optional fields (hit ENTER to skip):'
      options[:description] = prompt('  gem description: ')
      options[:summary] = prompt('  gem summary: ')
      options[:github_user] = prompt('  github user: ')
      options[:homepage] = prompt("  homepage (press ENTER to autofill with https://github.com/#{options[:github_user]}/#{options[:gem_name]}): ")
      options
    end

    def self.prompt(msg)
      print(msg)
      gets.strip
    end

    def self.run(options)
      new(options)
    end

    def initialize(options)
      @generator = Gemstrap::Generator.new
      @generator.run(options)
    end
  end
end
