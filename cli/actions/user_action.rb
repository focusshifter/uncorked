# = UserAction
class UserAction
  class << self
    def login
      email = CLI.ask('Your email') { |q| q.default = 'test@example.net' }

      token = API.root.related('login').post(email: email).property('token')

      CLI.say "Token: #{token}"
      API.authorize(token)

      EntrypointAction.root
    end

    def signup
      email = CLI.ask('Your email') { |q| q.default = 'test-new@example.net' }
      name = CLI.ask('Your name') { |q| q.default = 'Mister Awesome' }

      user = API.root.related('signup').post(email: email, name: name)
      token = user.property('token')

      CLI.say 'User created!'
      CLI.say "Token: #{token}"
      API.authorize(token)

      EntrypointAction.root
    end
  end
end
