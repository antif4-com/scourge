# frozen_string_literal: true

require 'yaml'

# Load all our thor files
module Scourge

  # TODO: There is probably a better way to do this, but I can't figure out how to
  # get config to be available across the entire module otherwise.
  @config = YAML.load_file('scrgcfg.yaml')

  def self.config
    @config
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
  end
end

#finally, load all of our sub features, doing this last to ensure everything is
# fully defined within the Scourge module from the perspective of sub features.
puts "loading sub files - #{self.class.name}"
Scourge.load_thorfiles('lib')


