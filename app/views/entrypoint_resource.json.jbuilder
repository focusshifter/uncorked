json.ignore_nil!

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

  l.login do |login|
    login.href url_for(LoginResource)
    login.title 'Get an auth token'
  end

  l.signup do |signup|
    signup.href url_for(SignupResource)
    signup.title 'Register as a new user'
  end
end
