require 'optparse'

module GifBot
  class CLI    
    class << self
      
      def set_options
        @options = {}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: gifbot [options]\n\nExample: gifbot --server=irc.freenode.net --nick=gifbot --channels=ruby,rails --enableActions"

          opts.separator ''
          opts.separator 'Options:'

          opts.on('--server [HOST]', 'Set the server to connect to') do |server|
            @options[:server] = server unless server.nil?
          end
          
          opts.on('--port [PORT]', 'Set the server port to connect to') do |port|
            @options[:port] = port unless port.nil?
          end
          
          opts.on('--ssl', 'Connect with ssl') do |ssl|
            @options[:ssl] = ssl unless ssl.nil?
          end

          opts.on('--nick [NICK]', 'Set gifbot\'s nickname') do |nick|
            @options[:nick] = nick unless nick.nil?
          end

          opts.on('--channels [CHANNELS]', 'Tell gifbot what channels to connect to (comma seperated, without hash)') do |channels|
            @options[:channels] = channels.split(',').map{ |c| '#' + c } unless channels.nil?
          end

          opts.on('--enableActions', 'Tell gifbot to respond to /me actions') do |action|
            @options[:action] = action.nil? ? false : true
          end

          opts.on( '-h', '--help', 'Display this help' ) do
            puts opts
            exit
          end

        end
        
        opts.parse!
                
        unless %w[server nick channels].all? { |k| @options.has_key?(k.to_sym) }
          puts opts
          exit
        end
      end
    
      def run!
        set_options

        GifBot.connect(@options)
      end
    
   end 
  end
end
