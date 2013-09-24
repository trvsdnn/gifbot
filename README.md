## HUH?
My cute little gif slinging irc bot for [http://whyday.org/](whyday). Gifs courtesy of [http://www.giphy.com/](giphy)

Requires ruby >= 1.9.1

## Usage
  
    # start up gifbot
    $ gifbot --server=irc.freenode.net --nick=gifbot --channels=ruby,rails


    # ask for some gifs in irc

    # a random gif
    <blahed> ?gifme
    <gifbot> http://media.giphy.com/media/ZuAoPnVw3R6Yo/giphy.gif
    
    # a dancing gif
    <blahed> ?gifme dancing
    <gifbot> http://media.giphy.com/media/ddOokp54QECd2/giphy.gif

    # a gif response to an action
    <blahed> /me laughs
    <gifbot> blahed right now: http://media.giphy.com/media/HdlXyEGKnfd8A/giphy.gif

    # to toggle action response gifs
    <blahed> ?action
    <gifbot> Action gifs are now enabled
    <blahed> ?action
    <gifbot> Action gifs are now disabled


## Installation
    $ gem install gifbot

  
