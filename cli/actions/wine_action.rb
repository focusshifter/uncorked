# = WineAction
class WineAction
  class << self
    def index
      CLI.say '=== Wines ==='

      CLI.choose do |menu|
        menu.prompt = 'Select wine to view'

        API.root.related('wines').related('wines').each do |wine|
          wine_id = wine[:id]
          menu.choice(wine_id, '', wine[:title]) { WineAction.show(wine_id) }
        end

        menu.choice(:back, '', '<- Back') { EntrypointAction.root }
      end
    end

    def show(id)
      wine = API.root.related('wine', id: id).first

      CLI.say "=== Wine #{wine[:title]} ==="

      if wine.related? 'reviews'
        wine.related('reviews').first.related('reviews').each do |review|
          CLI.say "#{review[:rating]} from #{review[:author]} with a comment #{review[:summary]}."
        end
      end

      CLI.choose do |menu|
        menu.prompt = 'Add a review for this wine or go back'
        menu.choice(:back, '', '( Review )') { ReviewAction.create(id) }
        menu.choice(:back, '', '<- Back') { WineAction.index }
      end
    end

    def create(winery_id)
      title = CLI.ask('Wine title') { |q| q.default = 'An awesome wine' }

      wine = API.root.related('wines').post(title: title, winery_id: winery_id)
      CLI.say 'Wine created!'

      WineAction.show(wine[:id])
    end
  end
end
