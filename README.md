= Uncorked, the API
This is a sample HAL-enhanced JSON API that pretends to be a clone of Untappd, but for wine instead of beer.

`Users` are allowed to register, log in and manage `wineries`, `wines` and `reviews`.
For now everyone is a superuser, as everyone is allowed to create or delete anyone's content (see 'Improvements' at the end of this document).

== Stack, detailed
Framework - Webmachine.
Persistence layer - Sequel backed by SQLite3, easily replaceable with any RDBMS of choice.

CLI - HAL-Client, HighLine.

Total time spent - around 20 hours, most of it went into the tinkering with Webmachine.

== Installation instructions

Install RVM and Ruby
Skip this step if Ruby is already installed on the target system.
```
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable
rvm install ruby
gem install bundler
```

Install Git, clone the repository and seed the databases.
```
sudo apt-get -y install git
git clone https://github.com/focusshifter/uncorked
cd uncorked/api
bundle install
bundle exec ruby ./db/seed.rb
```

=== Set ENV vars
Replace `uncorked_secret` with your own secret.
```
$ export UC_AUTH_SECRET="uncorked_secret"
```

== Run with WEBrick
```
$ bundle exec ruby ./app.rb
```

=== Run with Puma
```
$ bundle exec ruckup -p 3000
```
Replace 3000 with required port number if needed.

== Run tests
```
$ bundle exec cucumber
```
Coverage report could be found in `./coverage`.

== Read the Cucumber features
See `api/features/*.features`.

== Use the command-line client
```
cd cli
bundle install
bundle exec ruby ./cli.rb
```
Authorize or register to gain access to `Browse Wines` and `Browse Wineries` actions.

== Improvements, primary vectors

- Authorization: password-based log in procedure, user verification.
- Resource access: adopt a role-based permission system.
- Resource modification: allow to edit existing resources.
- DB: replace SQLite with proper RDBMS and start using migrations.
- CLI: implement missing functionality (for now - deleting resources).
- CLI: exception handing, at bare minumum - when creating resources.
