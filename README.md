# Dashub

> A better way to manage your projects pull requests.

Dashub is a dashboard that provides an aggregated view of all the pull
requests related to a project. If your project has many different repositories,
you can use Dashub to know which pull requests are open and what are the
the ones that you should review earlier.

### Setting up the application

To get the application up and running, install all the dependencies first:

~~~console
$ bundle install
~~~

Edit `config/database.yml` file as you prefer and create and set up the database:

~~~console
$ bin/rake db:create
$ bin/rake db:migrate
~~~

You also need to have valid GitHub API credentials in order to use the app in
your local machine. Get them in the settings page of your GitHub account, and then
configure your `.env` file as in the following snippet:

~~~
GITHUB_ACCESS_TOKEN=<<access_token>>
GITHUB_CLIENT_ID=<<client_id>>
GITHUB_CLIENT_KEY=<<client_secret>>
GUEST_USER=<<username of the guest user>>
~~~

Then you can start the server with

~~~console
$ bin/rails server
~~~
