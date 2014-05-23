require File.dirname(__FILE__) + '/../lib/gemstrap/cli.rb'

describe Gemstrap::CLI do
  it "does raise an error on missing name" do
    expect {
      Gemstrap::CLI.read([])  
    }.to raise_error
  end

  context "#read" do
    let(:args) { {
      gem_name: 'yourface_jokes',
      description: 'Generates your-face jokes. Guaranteed funny.',
      summary: 'Your-face joke generator',
      github_user: 'dieb',
      authors: ['John Dorian'],
      authors_emails: ['jd@sacredheart.com'],
      homepage: 'http://yourface.io'
    }}
    let(:sample_argv) {
      ["-n", args[:gem_name],
       "-a", args[:authors].first,
       "-m", args[:authors_emails].first,
       "-d", args[:description],
       "-s", args[:summary],
       "-g", args[:github_user],
       "-H", args[:homepage]]
    }
    let(:options) { Gemstrap::CLI.read(sample_argv) }

    it "does parse input arguments" do
      args.each do |key, expected|
        options[key].should eql(expected)
      end
    end

    it "does reuses description on summary" do
      sample_argv.delete args[:summary]
      sample_argv.delete "-s"
      options[:summary].should eql(args[:description])
    end
  end
end