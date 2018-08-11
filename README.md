# Area Motors Customer Enquiries

The original task requirements can be found in [TASK-SPECIFICATION.md](TASK-SPECIFICATION.md).

## Tasks

- ✅ Allow employees to click “check for new enquiries”
- ✅ Parses the sample email enquiries into a standard and structured format
- ✅ Allows an employee to mark the customer enquiry as “done”
- ✅ Be able to search for a particular customer enquiry
- ✅ Mark a customer enquiry as “invalid” if it has an invalid email address
- ✅ Introduce other “states” that a customer enquiry can be in other than “done” and “invalid” so that they can have a better idea of what needs to be done.

## Usage

### Cloning & running the app

Clone the repo and change your directory to the newly cloned repo:

    git clone git@github.com:MikeRogers0/AreaMotors.git && cd AreaMotors

Use [Bundler](https://bundler.io/) to install the ruby gems:

    bundle

Use [Yarn](https://yarnpkg.com/en/) to install NPM managed assets:

    yarn

Create & setup the applications Database:

    bundle exec rails db:setup

Start the application:

    bundle exec rails s

Now navigate you browser to the IP/Port rails is listening (most likely [0.0.0.0:3000](http://0.0.0.0:3000)) on & you should see the Area Motors app.

### Running the tests

I used Rspec to write all the test around this task. You can run them with the command:

    bundle exec rspec

### System Requirements

- Ruby 2.5.1
- Bundler 1.16.1
- PostgreSQL 10.1
- Yarn 1.7.0
