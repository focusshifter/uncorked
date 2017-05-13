class WineryAction
  class << self
    def index
      CLI.say '=== Wineries ==='

      CLI.choose do |menu|
        menu.prompt = 'Select winery to view'

        API.query.wineries.wineries.each do |winery|
          menu.choice(winery.id, '', winery.title) { WineryAction.show(winery.id) }
        end

        menu.choice(:back, '', 'Back') { EntrypointAction.root }
      end
    end

    def show(id)
      winery = API.query.wineries(id: id).first

      CLI.say "=== Winery #{winery.title} ==="

      CLI.choose do |menu|
        menu.prompt = 'Select a wine of this winery or go back'

        winery.wines.each do |wine|
          menu.choice(wine.id.to_s, '', wine.title) { } #  WineAction.show(wine.id) }
        end

        menu.choice(:back) { WineryAction.index }
      end
    end
  end
end
