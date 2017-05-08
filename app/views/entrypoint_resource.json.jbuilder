json._links do |l|
  l.self do |slf|
    slf.href '/'
    slf.title 'API Entrypoint'
  end

  l.wineries do |wineries|
    wineries.href url_for(WineriesResource)
    wineries.title 'The collection of Wineries'
  end

  l.wines do |wines|
    wines.href url_for(WinesResource)
    wines.title 'The collection of Wines'
  end

  # l.styles do |styles|
  #   styles.href url_for(StylesResource)
  # end
end
