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
        $ bundle exec bin/simple-server-healthcheck
      ```

### Contributing

  1. Enable the git pre-commit hook to run test suite before commiting code

      ```
        $ ln -s -f ../../git-hooks/pre-commit .git/hooks/pre-commit
      ```

### TODOs

Add bare minimum features:
  1. Script Utility (meta)
      - [ ] Server is unhealthy is /health is not found
      - [ ] Parse timestamp from provided HTML at /health endpoint
  1. Script Utility
      - [ ] Accept a list one or more server hosts/ports (server-1.example.com:8080, server-2.example.com:7070)
      - [ ] To check the health of a single server, query the server's `/health` endpoint,
      - [ ] Output a list of servers that is unhealthy, along with any other diagnostic information you feel is useful.
      - [ ] A server is defined to be healthy if and only its "Last Updated" timestamp is less than N minutes old (where N is a command-line argument to the program).
      - [ ] The tool is expected to be run once every 5 minutes. In other words: it should complete in less than 5 minutes

Add extra features:
  1. Development Support
      - [ ] Use [`rspec`](https://github.com/rspec/rspec) testing (try to TDD)
      - [ ] Simple CI with Travis
      - [ ] Make this a contributable project
  1. Script Potability
      - [ ] Put it in a container
  1. Integration Testing
      - [ ] Build a test rig

Done:
  1. Script Utility (meta)
      - [X] Provide json ~~array~~ output
      - [X] An unreachable server is a bad server
      - [X] Make connection attempt to provided list of servers
      - [X] Sanitize input parameters
      - [X] See if TDD is viable (not right now)
      - [X] Make it a [`thor`](https://github.com/erikhuda/thor) CLI app
  1. Development Support
      - [X] Communicate dependecies with Gemfile/Gemfile.lock
      - [X] Use [`rubocop`](https://github.com/bbatsov/rubocop) for linting (to keep myself in line)
      - [X] Use git pre-commit hook for low-fidelity CI
