json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href url_for(WinesResource)
    slf.title 'The collection of Wines'
  end
end

json._embedded do
  json.wines @wines do |wine|
    json._links do |l|
      l.self do |slf|
        slf.href url_for(WineResource, id: wine.uuid)
        slf.title wine.title
      end

      l.winery do |winery|
        winery.href url_for(WineryResource, id: wine.winery.uuid)
        winery.title wine.winery.title
      end

      l.reviews do |reviews|
        reviews.href url_for(ReviewsResource, wine_id: wine.uuid)
        reviews.title "Reviews for #{wine.title}"
      end
    end

    json.id wine.uuid
    json.title wine.title
  end
end
