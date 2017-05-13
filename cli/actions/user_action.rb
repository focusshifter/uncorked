class UserAction
  class << self
    def login
      email = CLI.ask('Your email') { |q| q.default = 'test@example.net' }
      token = API.query.login.post(email: email).token
      CLI.say "Token: #{token}"
      API.authorize(token)

      EntrypointAction.root
    end

    def signup
      email = CLI.ask('Your email') { |q| q.default = 'test-new@example.net' }
      name = CLI.ask('Your name') { |q| q.default = 'Mister Awesome' }
      user = API.query.signup.post(email: email, name: name)
      CLI.say 'User created!'
      CLI.say "Token: #{user.token}"
      API.authorize(token)

      EntrypointAction.root
    end
  end
end
