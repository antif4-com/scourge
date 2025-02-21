require 'droplet_kit'

module Scourge

  class DigitalOcean < ServerFactory
    register_host "DigitalOcean"

    desc "list servers", "list active servers"
    def list_servers
      apikey = Scourge.config['hosts']['keys']['digitalocean']['apikey']
      client = DropletKit::Client.new(access_token: apikey)

      client.droplets.all().each do |droplet|
        d = create_server_from_droplet (droplet)
        puts d.name
      end
    end

    desc "create_server", "create a DO server"
    def create_server
      DigitalOceanServer.new
    end

    no_commands do
      def create_server_from_droplet (droplet)
        d = create_server
        d.droplet = droplet
        d
      end
    end
  end

  class DigitalOceanServer < Server
    attr_accessor :droplet

    def name
      droplet.name
    end
  end
end