require 'cgi'
require 'uri'
require 'open-uri'
require 'cinch'
require 'nokogiri'
require 'gifbot/cli'
require 'gifbot/version'

module GifBot
  GIFBIN_URL = 'http://www.gifbin.com'
  
  def self.connect(options={})
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
          query   = CGI.escape(query)
          gifs    = []
          results = Nokogiri::HTML( open("#{GIFBIN_URL}/search/#{query}/") )
          
          results.xpath('//div[@class="thumb-cell"]//a').each do |a|
            gifs << a['href'].sub(/^\//, '')
          end
          
          if gifs.empty?
            "damn, no gif for \"#{query}\""
          else
            id = gifs[rand(gifs.length)]
            page = Nokogiri::HTML( open("#{GIFBIN_URL}/#{id}") )

            image_url_from_page(page)
          end
        end
        
        def random
          page = Nokogiri::HTML(open("#{GIFBIN_URL}/random"))
          
          image_url_from_page(page)
        end
        
        def image_url_from_page(page)
          URI.escape(GIFBIN_URL + page.xpath('//div[@class="box"]//img[@class="gif"]').first['src'])
        end
      end
      
      on :message, /^?randomgif/ do |m|
        m.reply random
      end
      
      on :message, /^?gifme (.+)/ do  |m, query|
        m.reply search(query)
      end
      
    end
    
    bot.start
  end
end
