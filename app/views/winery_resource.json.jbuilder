json._links do |l|
  l.self do |slf|
    slf.href url_for(WineryResource, id: @winery.uuid)
    slf.title "Winery #{@winery.title}"
  end

  l.wines do |wines|
    wines.href url_for(WinesResource, winery_id: @winery.uuid)
    wines.title "Wines of #{@winery.title}"
  end
end

json.title @winery.title
json.created_at @winery.created_at
json.updated_at @winery.updated_at
