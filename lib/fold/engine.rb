module Fold
  class Engine
    def initialize source
      @source= source
    end
    
    def lines
      @source.split(/\n/).reject{|line| line.blank?}
    end
    
    def render context
      precompiler = precompiler_class.new
      precompiler.fold(lines).children.map do |child| 
        child.render(precompiler)
      end
    end
    
#    *** me hard
    def precompiler_class
      @precompiler||= instance_eval "#{self.class.to_s.split(/::/).first}::Precompiler"
    end
  end
end
