# = ReviewAction
class ReviewAction
  class << self
    def create(wine_id)
      rating = CLI.ask('Review rating (1-5)') { |q| q.default = '5' }
      summary = CLI.ask('Summary (a couple of words)')

      API.root.related('wine', id: wine_id).first.related('reviews')
         .post(rating: rating, summary: summary, wine_id: wine_id)
      CLI.say 'Review created!'

      WineAction.show(wine_id)
    end
  end
end
