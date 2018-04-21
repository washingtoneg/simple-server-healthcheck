simple-server-healthcheck
=========================

## About

`simple-server-healthcheck` is a Ruby command line program that checks the health of a pool of HTTP servers, then exits.


### System dependencies

  * Ruby version: 2.3

### Installation Instructions

#### Ruby

  1. Install rbenv (instructions [here](https://github.com/rbenv/rbenv#installation))

  1. Install Ruby 2.3.5

      ```
        $ rbenv install 2.3.5
      ```

### Getting Started

  1. Clone the repo:

      ```
        $ git clone git@github.com:washingtoneg/simple-server-healthcheck.git
      ```

  1. Run `simple-server-healthcheck`:

      ```
        $ cd simple-server-healthcheck
        $ bundle exec simple-server-healthcheck
      ```

### TODOs

Add bare minimum Features:
  1. Development Support
      - [ ] Communicate dependecies with Gemfile/Gemfile.lock
      - [ ] Use `rubocop` for linting (to keep myself in line)
      - [ ] Use `rspec` testing (try to TDD)
  1. Script Utility
      - [ ] Accept a list one or more server hosts/ports (server-1.beeswax.com:8080, server-2.beeswax.com:7070)
      - [ ] Output a list of servers that is unhealthy, along with any other diagnostic information you feel is useful.
      - [ ] A server is defined to be healthy if and only its "Last Updated" timestamp is less than N minutes old (where N is a command-line argument to the program).
      - [ ] The tool is expected to be run once every 5 minutes. In other words: it should complete in less than 5 minutes

Add extra features
  1. Development Support
      - [ ] Simple CI with Travis
  1. Script Potability
      - [ ] Put it in a container
  1. Integration Testing
      - [ ] Build a test rig
