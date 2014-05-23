# gemstrap

Fastest way to bootstrap a new ruby gem.

## Installing

    $ gem install gemstrap


## Usage

    $ gemstrap -n yourface_jokes -a 'John Dorian' -m jd@sacredheart.com -d "Generates your-face jokes. Guaranteed funny." -s "Your-face joke generator" -g dieb

       creating gem yourface_jokes
       gem data
         using   gem_name         => yourface_jokes
         using   authors          => ["John Dorian"]
         using   authors_emails   => ["jd@sacredheart.com"]
         using   description      => Generates your-face jokes. Guaranteed funny.
         using   summary          => Your-face joke generator
         using   github_user      => dieb
       generate
         create  yourface_jokes
         create  yourface_jokes/.gitignore
         create  yourface_jokes/README.md
         create  yourface_jokes/yourface_jokes.gemspec
         create  yourface_jokes/Rakefile
         create  yourface_jokes/Gemfile
         create  yourface_jokes/lib
         create  yourface_jokes/lib/yourface_jokes.rb
         create  yourface_jokes/lib/yourface_jokes/version.rb
         create  yourface_jokes/spec
         create  yourface_jokes/spec/spec_helper.rb
