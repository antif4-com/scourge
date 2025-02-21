require 'droplet_kit'

module Scourge

  class DigitalOcean < ScourgeHost
    register_host "DigitalOcean"

    desc "list servers", "list active servers"
    def list_servers
      apikey = Scourge.config['hosts']['keys']['digitalocean']['apikey']
      client = DropletKit::Client.new(access_token: apikey)

      client.droplets.all().each do |droplet|
        puts droplet.name
      end
    end
  end
end