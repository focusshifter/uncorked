json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href url_for(ReviewResource, wine_id: @wine.uuid, id: @review.uuid)
  end

  l.wine do |wine|
    wine.href url_for(WineResource, id: @wine.uuid)
    wine.title @wine.title
  end
end

json.id @review.uuid
json.rating @review.rating
json.summary @review.summary
json.author @review.user.name
