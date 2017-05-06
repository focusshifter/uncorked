json._links do |l|
  l.self do |slf|
    slf.href url_for(WineryResource, id: @winery.uuid)
  end

  l.wines do |wines|
    wines.href url_for(WinesResource, winery_id: @winery.uuid)
  end
end

json.name @winery.name
json.created_at @winery.created_at
json.updated_at @winery.updated_at
