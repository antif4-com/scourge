
require 'droplet_kit'

module Scourge
  @available_hosts = {}
  def self.available_hosts
    @available_hosts
  end

  class ServerFactory < Thor

    attr_accessor :name

    no_commands do

      def self.register_host (host)
        @name = host
        Scourge.available_hosts[host] = self
      end

      def list_servers
        puts "<implement me>"
      end

      def create_server
        puts "<implement me>"
      end
    end
  end

  class Server
    attr_reader :name
  end
end