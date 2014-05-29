# gemstrap

[![Build Status](https://travis-ci.org/dieb/gemstrap.svg?branch=master)](https://travis-ci.org/dieb/gemstrap)
[![Code Climate](https://codeclimate.com/github/dieb/gemstrap.png)](https://codeclimate.com/github/dieb/gemstrap)

[travis]: http://travis-ci.org/dieb/travis
[codeclimate]: https://codeclimate.com/github/dieb/gemstrap

Fastest way to bootstrap a new ruby gem.

![Generation screenshot](https://raw.githubusercontent.com/dieb/gemstrap/master/screenshot.png "Generation screenshot")

## Installing

    $ gem install gemstrap

## Usage

    $  gemstrap -h
    Usage: gemstrap [options]
        -h, --help                       Display this message
        -V, --version                    Display version
        -n, --name GEM_NAME              Gem name
        -d, --description GEM_DESC       Gem description
        -a, --authors AUTHORS            CSV list of authors names (e.g. John Dorian, Christopher Turk)
        -m, --emails AUTHORS_EMAILS      CSV list of corresponding authors emails (e.g. jd@sacredheart.com, turk@sacredheart.com)
        -s, --summary SUMMARY            Gem summary. If not supplied takes description value.
        -g, --github_user GITHUB_USER    Github user. If not blank, homepage will be set to GITHUB_USER/GEM_NAME
        -H, --homepage HOMEPAGE          Homepage URL. Takes priority over the github_user parameter.
        -i, --interactive                Interactive mode. Prompt for user the parameters for gem generate.

        