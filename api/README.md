= Uncorked, API
This is a sample HAL-enhanced JSON API that pretends to be a clone of Untappd, but for wine instead of beer.

`Users` are allowed to register, log in and manage `wineries`, `wines` and `reviews`.
For now everyone is a superuser, as everyone is allowed to create or delete anyone's content (see 'Improvements' at the end of this document).

== Stack, detailed
Framework - Webmachine.
Persistence - Sequel backed by SQLite3, easily replaceable with any RDBMS of choice.

Total time spent - around 20 hours, most of it went into the tinkering with Webmachine.

== Installation instructions

=== Set ENV vars
Replace `uncorked_secret` with your own secret.
```
$ export UC_AUTH_SECRET="uncorked_secret"
```

=== Run
```
$ bundle exec ruby ./app.rb
```

=== Run with Puma
```
$ bundle exec ruckup
```


= Run tests
```
$ bundle exec cucumber
```
Coverage report could be found in `./coverage`.

== Improvements, possible vectors

- Authorization: password-based log in procedure, user verification.
- Resource access: adopt a role-based permission system.
- DB: replace SQLite with proper RDBMS.
