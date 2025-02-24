
Thor::Util.load_thorfile"lib/scourge.rb"

# Load all our thor files
module Scourge

  initialize_scourge

  class Sys < Thor
    desc "readme", "Describes scourge's overall philosophy"
    def readme
      puts "I'll get to it later. Sorry."
    end

    desc "prep", "(dev) Prep scourge to push to mainline"
    def prep
      # TODO: copy over latest scrgcfg.yml -> scrgcfg_example.yml. However, need to worry about keys.
      # so not doing it now. But leaving this todo so I think about it.
      #zap everything that shouldn't escape
      clean_template = Scourge.clean_tree(Scourge.config.clone)

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
      Scourge.config
    end
  end
end