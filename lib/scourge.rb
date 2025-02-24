require 'yaml'
require 'thor'

module Scourge

  class Key
    attr_accessor :key

    def initialize(key_to_set)
      @key = key_to_set
    end

    # for programming ease of use, can pas the key class directly to functions expecting a key string
    def to_s
      @key
    end
  end

  # this is me being lazy, it lets me put a key into a YAML file and mark it with !KEY
  # then, when it's loaded, scourge will wrap it in a Key class, and it'll be protected
  # properly from then on
  YAML.add_domain_type("", "KEY") do |_, data|
    #puts "WARNING: found a key, wrapping it"
    Key.new(data)
  end

  def self.config
    @config
  end

  def self.sys_config
    @sys_config
  end

  def self.save_config(file=nil)
    #if we have a new filename passed in, save it for future usage
    sys_config[:config_name] = file unless file.nil?


    file = sys_config[:config_name]
    File.open(file, 'w') do | file|
      YAML.dump(@config, file)
    end
  end

  # saving and loading configs
  def self.load_config(file)
    @config = YAML.safe_load_file(file, permitted_classes: [Key])
  end

  def self.load_sys_config(file)
    @config['scourge_sys'] = {} unless @config['scourge_sys']
    @sys_config = @config['scourge_sys']
    @sys_config[:config_name] = file
  end


  # for now, the main initialization method that ensures all the internal configuration
  # state is loaded (config, manifolds, etc.)
  def self.initialize_scourge(file=nil)
    file = 'scrgcfg.yaml' if file.nil?

    load_config(file)

    load_sys_config(file)
  end

  # used to load all our sub features, do it in two passes so we can make sure there is a defined base
  # before loading all secondary functionality
  def self.load_thorfiles(dir)
    Dir.chdir(dir) do
      first_pass_files = Dir.glob('*.thor').delete_if { |x| not File.file?(x) }
      second_pass_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
      second_pass_files = second_pass_files - first_pass_files

      first_pass_files.each do |f| Thor::Util.load_thorfile(f) end
      second_pass_files.each do |f| Thor::Util.load_thorfile(f) end
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


  def self.print_table_columns(data, columns)
    a = []
    row = []

    columns.each do |column|
      row << column.to_s
    end

    a << row

    data.each do |record|
      row = []
      columns.each do |column|
        row << record.send(column.to_s)
      end
      a << row
    end

    a
  end
end

Scourge.load_thorfiles('lib')