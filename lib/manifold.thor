


module Scourge

  class Manifold < Thor

    name = "unnamed manifold"

    hosts = {}
    servers = {}
    installed_software = {}

    desc "print","display the manifold"
    def print
      puts "--< #{name} >--"
      hosts.each do |name, host|

      end
    end
  end
end