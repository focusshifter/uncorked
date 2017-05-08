json._links do |l|
  l.self do |slf|
    slf.href url_for(WineriesResource)
    slf.title 'The collection of Wineries'
  end
end

json._embedded do
  json.wineries @wineries do |winery|
    json._links do |l|
      l.self do |slf|
        slf.href url_for(WineryResource, id: winery.uuid)
        slf.title "Winery #{winery.title}"
      end

      l.wines do |wines|
        wines.href url_for(WinesResource, winery_id: winery.uuid)
        wines.title "Wines of #{winery.title}"
      end
    end

    json.title winery.title
  end
end
