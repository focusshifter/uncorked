# = WineryAction
class WineryAction
  class << self
    def index
      CLI.say '=== Wineries ==='

      CLI.choose do |menu|
        menu.prompt = 'Select winery to view, add a new winery or go back'

        API.root.related('wineries').related('wineries').each do |winery|
          winery_id = winery[:id]
          menu.choice(winery_id, '', winery[:title]) { WineryAction.show(winery_id) }
        end

        menu.choice(:back, '', '( New winery )') { WineryAction.create }
        menu.choice(:back, '', '<- Back') { EntrypointAction.root }
      end
    end

    def show(id)
      winery = API.root.related('winery', id: id).first

      CLI.say "=== Winery #{winery[:title]} ==="

      CLI.choose do |menu|
        menu.prompt = 'Select a wine of this winery, add a new wine or go back'

        if winery.related? 'wines'
          winery.related('wines').each do |wine|
            wine_id = wine[:id]
            menu.choice(wine_id, '', wine[:title]) { WineAction.show(wine_id) }
          end
        end

        menu.choice(:back, '', '( New wine )') { WineAction.create(id) }
        menu.choice(:back, '', '<- Back') { WineryAction.index }
      end
    end

    def create
      title = CLI.ask('Winery title') { |q| q.default = 'An awesome winery' }

      winery = API.root.related('wineries').post(title: title)
      CLI.say 'Winery created!'

      WineryAction.show(winery[:id])
    end
  end
end
