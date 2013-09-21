require 'cgi'
require 'uri'
require 'open-uri'
require 'cinch'
require 'giphy'
require 'gifbot/cli'
require 'gifbot/version'

module GifBot
  def self.connect(options={})
    action = options[:action]
    bot = Cinch::Bot.new do
      configure do |c|
        c.server   = options[:server]
        c.nick     = options[:nick]
        c.channels = options[:channels]
        c.port = options[:port] if options[:port]
        c.ssl.use = options[:ssl] if options[:ssl]
      end
      
      helpers do
        def search(query)
          query   = CGI.escape(query).gsub("+","-")
          begin
            Giphy.screensaver("#{query}").image_original_url
          rescue
            query.nil? ? "Unable to retrieve a random gif from giphy!" : "The internet has failed us. No gif for \"#{query}\"!"
          end
        end
      end
      
      on :message, /^?gifme\s*(.*)/ do  |m, query|
        m.reply search(query)
      end

      on :action, /(\w+\s*\w*\s*\w*)/ do  |m, query| 
        if action
          m.reply "#{m.user.nick} right now: #{search(query)}"
        end
      end

      on :message, /^?help/ do  |m|
        help = "For a good time,
        - ?gifme
            - Provide a search string, or leave blank for a random gif!
        - /me
            - Toggle with ?action
            - Only the first 3 words of the action are used to search"

        m.reply help
      end

      on :message, /^?action/ do  |m|
        action = !action
        m.reply "Action gifs are now #{action ? 'enabled' : 'disabled'}"
      end

    end
    
    bot.start
  end
end
