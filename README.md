simple-server-healthcheck
=========================

## About

`simple-server-healthcheck` is a Ruby command line program that checks the health of a pool of HTTP servers, then exits.

### Assumptions

  * Each server responds to requests GET requests to `/health` with HTML in [this format](https://github.com/washingtoneg/simple-server-healthcheck/blob/master/test/health)


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

  1. Run `simple-server-healthcheck` for usage instructions:

      ```
        $ bundle exec bin/simple-server-healthcheck
      ```

### Contributing

  1. Enable the git pre-commit hook to run test suite before commiting code

      ```
        $ ln -s -f ../../git-hooks/pre-commit .git/hooks/pre-commit
      ```

### Testing

Start up a simple web server locally for testing `simple-server-health`. There is a stub of the expected [server response](https://github.com/washingtoneg/simple-server-healthcheck/blob/master/test/health) located in the `test/` directory. You can serve up this file using a (Python) SimpleHTTPServer webserver in the background by running the following:

  ```
    $ port=7070
    $ cd test
    $ nohup python -m SimpleHTTPServer $port >/tmp/server-${port}.log 2>&1 &
  ```

You should now be able to run `simple-server-healthcheck` against the server:

  ```
    $ bundle exec bin/simple-server-healthcheck health --age 10 --servers localhost:7070
  ```

### TODOs

Add extra features:
  1. Development Support
      - [ ] Use [`rspec`](https://github.com/rspec/rspec) testing (try to TDD)
      - [ ] Simple CI with Travis
      - [ ] Make this a contributable project
  1. Script Potability
      - [ ] Put it in a container
  1. Integration Testing
      - [ ] Build a test rig
      - [ ] Make SERVER_REGEX more robust
      - [ ] Allow "Last Updated" timestamp test fixture to be programmatically generated

Done:

Add bare minimum features:
  1. Script Utility (meta)
      - [X] Parse timestamp from provided HTML at /health endpoint
      - [X] Server is unhealthy is /health is not found
      - [X] Provide json ~~array~~ output
      - [X] An unreachable server is a bad server
      - [X] Make connection attempt to provided list of servers
      - [X] Sanitize input parameters
      - [X] See if TDD is viable (not right now)
      - [X] Make it a [`thor`](https://github.com/erikhuda/thor) CLI app
  1. Script Utility
      - [X] The tool is expected to be run once every 5 minutes. In other words: it should complete in less than 5 minutes
      - [X] Output a list of servers that is unhealthy, along with any other diagnostic information you feel is useful.
      - [x] A server is defined to be healthy if and only its "Last Updated" timestamp is less than N minutes old (where N is a command-line argument to the program).
      - [X] Accept a list one or more server hosts/ports (server-1.example.com:8080, server-2.example.com:7070)
      - [X] To check the health of a single server, query the server's `/health` endpoint,
  1. Development Support
      - [X] Communicate dependecies with Gemfile/Gemfile.lock
      - [X] Use [`rubocop`](https://github.com/bbatsov/rubocop) for linting (to keep myself in line)
      - [X] Use git pre-commit hook for low-fidelity CI
