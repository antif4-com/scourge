require 'droplet_kit'

module Scourge
  class Dns < Thor

    desc "list DOMAIN","List all records for DOMAIN"
    def list(domain)


      apikey = Scourge.config['hosts']['keys']['digitalocean']['apikey']
      client = DropletKit::Client.new(access_token: apikey)

      records = client.domain_records.all(for_domain: domain)

      print_table Scourge.add_columns_to_table([:type, :name, :data],records)

      # res = client.domain_records.update(trouble_entry, for_domain: domain, id: trouble_entry.id)
      #
      # puts res
    end
  end
end