# ValveAdjustments.com

## Inspiration

Adjusting [shim-under-bucket valves](https://www.revzilla.com/common-tread/why-do-bikes-use-shim-under-bucket-valve-adjusters)
is a common maintenance task on motorcycles that requires a spreadsheet or notepad to do the (basic) math and sort out
which shims to use with which valves. 

There are online calculators but I have not found a resource to do the calculation, automatically assign shims to 
valves, and log the maintenance history (and track leftover shims). This seemed like a good side project to refresh 
coding skills and technology (Docker, AWS). 

## Stack

* Ruby on Rails 7
  * `paper_trail` for tracking state of a valve adjustment
  * `devise` for authentication
  * `factory_bot` for test factories
  * `sidekiq` for jobs
* Hotwire (Stimulus, Turbo) for presentation logic
* Bootstrap for styling
* Postgres
* Nginx
* Docker containers deployed to AWS (App Runner, ECR)
* Rollbar for error monitoring

## To do

* Show a timeline of valve + shim state before and after each valve adjustment.
* Add a generic maintenance log feature (date, mileage, work done) and compose a timeline merged with valve adjustments.
* Delete unused shims - maybe user has taken an extra shim and used it on another engine.

## Usage

### Development

`docker compose up --build` # include `--build` if first time or needing image changes

***Commands***

`docker ps` # get container names, specifically `motorcycleshims_web` and `postgres`

`docker attach {motorcycleshims_web container name}` # attach to STDIN for debugging, detach via `ctrl-p, ctrl-q`

`docker exec -it {motorcycleshims_web container name} '/bin/bash'` # connect to container for `rails c` and rake tasks

### Site

`rake aws:deploy_site`

### Sidekiq

`rake aws:deploy_sidekiq`  # include `SKIP_UPLOAD=true` if docker image has recently been uploaded via site deploy

### Audits

`rubocop -a` # lint check (commit automatic fixes then fix remaining poorly structured code)

`bundle-audit check --update` # vulnerability check (then update Gemfile)