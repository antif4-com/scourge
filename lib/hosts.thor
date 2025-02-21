
require 'droplet_kit'

module Scourge

  @available_hosts = {}
  def self.hosts
    @available_hosts
  end

  class ScourgeHost < Thor
    no_commands do

      def register_host (host)
        Scourge.available_hosts[host] = self
      end
    end
  end

  def self.load_hostfiles(dir)
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
      thor_files.each do |f|
        Thor::Util.load_thorfile(f)
      end
    end
  end
end