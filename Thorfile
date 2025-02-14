# frozen_string_literal: true

# Load all our thor files
module Scourge
  def self.load_thorfiles(dir)
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor').delete_if { |x| not File.file?(x) }
      thor_files.each do |f|
        Thor::Util.load_thorfile(f)
      end
    end
  end
end

Scourge.load_thorfiles('lib')
