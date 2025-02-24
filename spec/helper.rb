$TESTING = true

require "rspec"
require "thor"

# this needs to be loaded via Thor so that it can live in the sandbox
Thor::Util.load_thorfile"Thorfile"

# TODO: handle namespaces in specs better
# since scourge is created inside thor, it's stuck in the sandbox, this
# makes coding specs a little be nicer...I don't like this, but it works
# it feels way too dependent on Thor implementation details for my taste
Scourge = Thor::Sandbox::Scourge