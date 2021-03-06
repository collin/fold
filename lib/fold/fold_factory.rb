module Fold
  module FoldFactory
    Indent= 2
    class IndentationError < StandardError; end
    
    def self.included klass
      klass.extend ClassMethods
    end
    
    def produce line=''
      tabs = count_soft_tabs(line)
      line = line.sub(/^[ ]+/, '')
      attrs= {
        :text => line, 
        :tabs => tabs
      }

# This all happens because I need to access Precompiler attributes
# from within AbstractFold render methods
# Pretty much needs a nice refactor, but don't have the time.
# PS: thx ruby   
      fold = if klass= detect_class(line)
        klass.new attrs
      else
        AbstractFold.new attrs.merge(:tabs => -1)
      end
      
      instance_variables.each do |var|
        fold.instance_variable_set var, instance_variable_get(var)
  
        fold.metaclass.send :attr_accessor, var.gsub('@', '')
      end
      that = self
      fold.meta_def :method_missing do |meth, *args|
        return that.send(meth, *args) if that.respond_to?(meth)
        super
      end

      fold
    end
    
    def detect_class line
      return nil if line.blank?
      self.class.defined_folds.reverse.detect {|fold| fold::Regex and fold::Regex.match(line)}
    end
    
    def count_soft_tabs line
      spaces= line.index(/([^ ]|$)/)
      raise IndentationError if spaces.odd?
      spaces / Indent
    end
    
    module ClassMethods
      def folds id, regex=AbstractFold::Regex, clear_match=true, &block
        fold= Class.new(AbstractFold)
        fold.const_set :Regex, regex
        
        fold.send :define_method, :render, &block if block_given?
        fold.class.send :define_method, :clear_match do; clear_match end
        
        const_set id, fold
        defined_folds << fold
      end
      
      def defined_folds
        @folds||= []
      end
    end
  end
end