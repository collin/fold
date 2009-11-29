module Fold
  module SliceFactory
    def self.included klass
      klass.extend ClassMethods
    end
    
    def process line=''
      self.class.defined_slices.each do |slice|
        line.gsub! slice::Regex do |match|
          text = $1
          eval(slice::Block.to_ruby).call
        end
      end
      line
    end

#     def produce line=''
# # This all happens because I need to access Precompiler attributes
# # from within AbstractFold render methods
# # Pretty much needs a nice refactor, but don't have the time.
# # PS: thx ruby   
#       fold = if klass= detect_class(line)
#         klass.new attrs
#       else
#         AbstractFold.new attrs.merge(:tabs => -1)
#       end
#       
#       instance_variables.each do |var|
#         fold.instance_variable_set var, instance_variable_get(var)
#   
#         fold.metaclass.send :attr_accessor, var.gsub('@', '')
#       end
#       that = self
#       fold.meta_def :method_missing do |meth, *args|
#         return that.send(meth, *args) if that.respond_to?(meth)
#         super
#       end
# 
#       fold
#     end
    
    def detect_slice_class line
      return nil if line.blank?
      self.class.defined_slices.reverse.detect {|slice| slice::Regex and slice::Regex.match(line)}
    end
    
    module ClassMethods
      def slices id, regex=AbstractSlice::Regex, &block
        slice= Class.new(AbstractSlice)

        slice.const_set :Regex, regex
        slice.const_set :Block, block
        
        const_set id, slice
        defined_slices << slice
      end
      
      def defined_slices
        @slices||= []
      end
    end
  end
end