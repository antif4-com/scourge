
require 'droplet_kit'

module Scourge
  class Hosts < Thor

    desc "list hosts", "list active hosts"
    def list
      puts Scourge.config
      apikey = Scourge.config['hosts']['keys']['digitalocean']['apikey']
      client = DropletKit::Client.new(access_token: apikey)

      client.droplets.all().each do |droplet|
       puts droplet.name
      end
    end
  end
endServices.stop
