require File.dirname(__FILE__) + '/../lib/gemstrap/cli.rb'

describe Gemstrap::CLI do
  it 'does raise an error on missing name' do
    expect do
      Gemstrap::CLI.read(['-n'])
    end.to raise_error
  end

  context '#read' do
    let(:args) do
      {
        gem_name: 'yourface_jokes',
        description: 'Generates your-face jokes. Guaranteed funny.',
        summary: 'Your-face joke generator',
        github_user: 'dieb',
        authors: ['John Dorian'],
        authors_emails: ['jd@sacredheart.com'],
        homepage: 'http://yourface.io'
      }
    end
    let(:sample_argv) do
      ['-n', args[:gem_name],
       '-a', args[:authors].first,
       '-m', args[:authors_emails].first,
       '-d', args[:description],
       '-s', args[:summary],
       '-g', args[:github_user],
       '-H', args[:homepage]]
    end
    let(:options) { Gemstrap::CLI.read(sample_argv) }

    it 'does parse input arguments' do
      args.each do |key, expected|
        expect(options[key]).to eql(expected)
      end
    end

    it 'does reuses description on summary' do
      sample_argv.delete args[:summary]
      sample_argv.delete '-s'
      expect(options[:summary]).to eql(args[:description])
    end
  end
end
