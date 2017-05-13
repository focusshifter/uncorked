json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href urlify(WineResource, id: @wine.uuid)
    slf.title @wine.title
  end

  l.winery do |winery|
    winery.href urlify(WineryResource, id: @wine.winery.uuid)
    winery.title @wine.winery.title
  end

  l.reviews do |reviews|
    reviews.href urlify(ReviewsResource, wine_id: @wine.uuid)
    reviews.title "Reviews for #{@wine.title}"
  end
end

json.id @wine.uuid
json.title @wine.title
json.created_at @wine.created_at
json.updated_at @wine.updated_at
