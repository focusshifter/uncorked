json._links do |l|
  l.wineries do |wineries|
    wineries.href url_for(WineriesResource)
  end

  l.wines do |wines|
    wines.href url_for(WinesResource)
  end

  # l.styles do |styles|
  #   styles.href url_for(StylesResource)
  # end
end
