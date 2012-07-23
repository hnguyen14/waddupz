h1 -> @title
if @passport.user
  p -> "Welcome #{@passport.user.displayName}"
else
  p -> "Welcome to #{@title}"
  a href: '/login', -> "Log in"
