json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href urlify(WineryResource, id: @winery.uuid)
    slf.title @winery.title
  end

  l.wines @winery.wines do |wine|
    json.href urlify(WineResource, id: wine.uuid)
    json.title wine.title
  end
end

json.id @winery.uuid
json.title @winery.title
json.created_at @winery.created_at
json.updated_at @winery.updated_at
