class EntrypointAction
  class << self
    def root
      CLI.say '=== UNCORKED CLIENT ==='

      if API.authorized?
        CLI.say "You are authorized."
      else
        CLI.say "You are not authorized. Use Signup or Login to authorize."
      end

      CLI.choose do |menu|
        menu.prompt = 'What do you want to do?'

        if API.authorized?
          menu.choice(:wineries) { WineryAction.index }
          menu.choice(:wines)
        end

        menu.choice(:login) { UserAction.login }
        menu.choice(:signup) { UserAction.signup }
        menu.choice(:exit)
        menu.default = :exit
      end
    end
  end
end
