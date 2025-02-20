require 'droplet_kit'

module Scourge
  class Dns < Thor
    desc "list DOMAIN","List all records for DOMAIN"

    def print_table_columns(data, columns)
      a = []
      row = []

      columns.each do |column|
        row << column.to_s
      end

      a << row

      data.each do |record|
        entry []
        columns.each do |column|
          entry << record.send column
        end
        a << entry
      end
    end
    def list(domain)


      apikey = Scourge.config['hosts']['keys']['digitalocean']['apikey']
      client = DropletKit::Client.new(access_token: apikey)

      records = client.domain_records.all(for_domain: domain)

      trouble_entry = nil
      a = []
      entry = []
      entry << "type"
      entry << "name"
      entry << "data"
      a << entry

      records.each do |record|
        entry = []
        entry << record.type
        entry << record.name
        entry << record.data

        a << entry

        if record.name == '_autodiscover._tcp'
          puts "found bad entry!"
          trouble_entry = record
        end
      end

      print_table(a)


      # res = client.domain_records.update(trouble_entry, for_domain: domain, id: trouble_entry.id)
      #
      # puts res
    end
  end
end