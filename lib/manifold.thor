


module Scourge

  class Manifold < Thor

    def initialize

      # either load the manifold from config or save a
      # blank one (the starting use case)
      if(Scourge.config[:manifold].is_a? Manifold)
        Scourge.manifold = Scourge.config[:manifold]
      else
        Scourge.config[:manifold] = Scourge.manifold
      end

      super
    end

    desc "print","display the manifold"
    def print
      puts Scourge.manifold
    end
  end


  @mfld = Manifold.new

  def manifold
    @mfld
  end

  def manifold=(value)
    @mfld = value
  end



end