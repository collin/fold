require 'ostruct'

module Fold
  class AbstractFold < OpenStruct
    Regex= //
    def initialize source={}
      attrs= {
        :text => '',
        :children => [],
        :tabs => -1
      }.merge(source)

      attrs[:text].gsub! self.class::Regex, '' if self.class.clear_match
      
      super attrs
    end
    
    def render
      text
    end
    
    def render_children
      children.map{|child| child.render}
    end
  end
end