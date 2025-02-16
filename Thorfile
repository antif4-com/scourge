# frozen_string_literal: true

require 'yaml'

# Load all our thor files
module Scourge

  # TODO: There is probably a better way to do this, but I can't figure out how to
  # get config to be available across the entire module otherwise.

  class Key
    @key = "undefined"

    def initialize(key_to_set)
      @key = key_to_set
    end

    def to_yaml_type
      "!Scourge/Key"
    end
    def key
      @key
    end
    def to_s
      @key.to_s
    end
  end

  # this is me being lazy, it lets me put a key into a YAML file and mark it with !KEY
  # then, when it's loaded, scourge will wrap it in a Key class and it'll be protected
  # properly from then on
  YAML.add_domain_type("", "KEY") do |type, data|
    puts "WARNING: found a key, wrapping it"
    Key.new(data)
  end

  @config = YAML.safe_load_file('scrgcfg.yaml', permitted_classes: [Key])

  def self.config
    @config
  end

  def self.save_config
    File.open('scrgcfg.yaml', 'w') do | file|
      YAML.dump(@config, file)
    end
  end

  # used to load all our sub features
  def self.load_thorfiles(dir)
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
      thor_files.each do |f|
        Thor::Util.load_thorfile(f)
      end
    end
  end

  class Sys < Thor
    desc "readme", "Describes scourge's overall philosophy"
    def readme
      puts "I'll get to it later. Sorry."
    end

    desc "prep", "(dev) Prep scourge to push to mainline"
    def prep
      # TODO: copy over latest scrgcfg.yml -> scrgcfg_example.yml. However, need to worry about keys.
      # so not doing it now. But leaving this todo so I think about it.
    end

    desc "flush", "(dev) Flush the scourge config"
    def flush
      Scourge.save_config
    end
  end
end

#finally, load all of our sub features, doing this last to ensure everything is
# fully defined within the Scourge module from the perspective of sub features.
Scourge.load_thorfiles('lib')




