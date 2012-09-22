h1 -> @title
if @passport.user
  p ->
    text "Welcome #{@passport.user.displayName}. "
    a href: '/logout', -> 'Log out'
    h3 'Add a keyword'
    form action: "/user/#{@passport.user._id}", method: 'post', ->
      input type: 'text', name: 'keyword'
      input type: 'submit'
    h3 'Make a post'
    form action: '/post', method: 'post', ->
      input type: 'text', name: 'title'
      input type: 'text', name: 'url'
      input type: 'text', name: 'keywords'
      input type: 'submit'
else
  p -> "Welcome to #{@title}"
  a href: '/login', -> 'Log in'
