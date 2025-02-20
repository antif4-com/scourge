


module Scourge

  class Host
    attr_accessor :id, :name
  end

  class Manifold < Thor

    no_commands do
      attr_accessor :hosts
      def generate_id
        rand(9999)
      end

    end

    def initialize
      @name = "unnamed manifold"

      @hosts = {}
      @servers = {}
      @installed_software = {}
    end


    desc "print","display the manifold"
    def print
      puts "--< #{name} >--"
      puts "TBD..."
    end

    desc "add_host HOST","add HOST to manifold"
    def add_host(host)
      h = Host.new
      h.id = generate_id
      h.name = host
      puts h.id
      puts h.name

      hosts[h.id] = h
    end

    desc "list_hosts","list all hosts in manifold"
    def list_hosts
      print_table(Scourge.print_table_columns(@hosts, [:id, :name]))
    end
  end
end