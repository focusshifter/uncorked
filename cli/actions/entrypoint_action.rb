# = EntrypointAction
class EntrypointAction
  class << self
    def root
      CLI.say '=== UNCORKED CLIENT ==='

      auth_prompt

      CLI.choose do |menu|
        menu.prompt = 'What do you want to do?'

        if API.authorized?
          menu.choice(:wineries, '', 'Browse Wineries') { WineryAction.index }
          menu.choice(:wines, '', 'Browse Wines') { WineAction.index }
        end

        menu.choice(:login, '', 'Login') { UserAction.login }
        menu.choice(:signup, '', 'Signup') { UserAction.signup }
        menu.choice(:exit, '', 'Exit')
        menu.default = :exit
      end
    end

    def auth_prompt
      if API.authorized?
        CLI.say 'You are authorized.'
      else
        CLI.say 'You are not authorized. Use Signup or Login to authorize.'
      end
    end
  end
end
