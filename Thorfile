# frozen_string_literal: true

require 'yaml'

# Load all our thor files
module Scourge

  class Key
    @key = "<undefined>"

    def initialize(key_to_set)
      @key = key_to_set
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



  # used to clean a hash of keys, or other sensitive information before creating
  # a template
  def self.clean_tree(the_hash)

    new_hash = {}
    # TODO: there must be a better way to do this?
    # ec - and to be clear, by "this" I mean both the method in which I'm cleaning
    # the config yaml (by creating a Key type that filters itself out) as well
    # as the way in which I am searching through this Hash to find all the Key
    # elements. I wanted a "deep" copy and select but it doesn't appear to exist?
    the_hash.each do |k, v|

      val = v

      if v.is_a? Key
        val = Key.new("<insert_key_here>")
      end

      if v.is_a? Hash
        val = clean_tree(v)
      end

      new_hash[k] = val
    end

    new_hash
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

      config_template = Scourge.config.clone

      #zap everything that shouldn't escape
      clean_template = Scourge.clean_tree(config_template)

      File.open('scrgcfg_example.yaml', 'w') do | file|
        YAML.dump(clean_template, file)
      end
    end

    desc "flush", "(dev) Flush the scourge config"
    def flush
      Scourge.save_config
    end

    desc "play", "(dev) DO NOT CALL - it's a playground"
    def play

    end
  end
end

#finally, load all of our sub features, doing this last to ensure everything is
# fully defined within the Scourge module from the perspective of sub features.
Scourge.load_thorfiles('lib')