var Fold = {};

Fold.AbstractFold = function(attrs) {
  var fold = function() {
    Fold.AbstractFoldInstance.apply(this, arguments);
  }
  
  jQuery.extend(fold.prototype, attrs);
};

Fold.AbstractFoldInstance = function() {
  initialize: function(source) {
    source||(source={});
    this.attrs = jQuery.extend({
      :text => '',
      :children => [],
      :tabs => -1
    }, source);
      
    this.attrs[:text].replace(this.regex, '')
  }
};

Fold.AbstractFoldInstance.prototype = {
    renderChildren: function() {
      var i, length = this.children.length, map = [];
      for(i=0; i < length; i++)
        map.push(this.children[i].render())
      return map.join('');
    }
};

Fold.FoldFactory = {
  mixin: function(func) {
    func.definedFolds = [];
    jQuery.extend(func, this.classMethods);
    jQuery.extend(func.prototype, this.instanceMethods);
  }

  ,instanceMethods: {
    produce: function(line) {
      line||(line='');
      var tabs = this.count_soft_tabs(line);
      line = line.replace(/^[ ]+/, '');
      var attrs= {
        :text => line, 
        :tabs => tabs
      };
  
      if(klass = this.detectClass(line))
        return new klass(attrs);
      else
        return new Fold.AbstractFold(jQuery.extend(attrs,{tabs: -1});
    }
  
    ,detectClass: function(line) {
      if(line.match(/^[ |\t|\n]+$/) return null
      var length = this.defined_folds.length
        ,fold;
      // Search in reverse order, last defined fold matches first.
      for(length--; length >= 0; length--) {
        fold = this.defined_folds[length];
        if(fold.regex && fold.regex.match(line) break;
      }
      return fold;
    }

    ,countSoftTabs: function(line) {
      var spaces= line.indexOf(/([^ ]|$)/);
      if(spaces % 2 === 1) throw "Only use 2 spaces for indentation!";
      return spaces / this.indent;
    }
  }

  ,classMethods: {
    folds: function(id, regex, block) {
      regex||(regex = new Regexp());
      block||(block = function() {return this.text;})
      var fold = Fold.AbstractFold({
        regex: regex
        ,render: block
      });
      this.definedFolds.push(fold);
      this[id] = fold;
    }
  }
};

Fold.Precompiler = function() {}

Fold.Precompiler.prototype = {
  fold: function(lines) {
    var lastLine = this.produce();

    if(lines.length === 0) return lastLine;

    var  parentLine = null
        ,parent_stack = []
        ,line
        ,that = this
        ,indend;

      jQuery(lines).each(function(text) {
        line = that.produce(text);

        indent = line.tabs - last_line.tabs;

        if(indent > 1) throw "IndentationError";
        
        if(this["step_in?"](indent)) {
          parentLine = lastLine;
          parentLine.children.push(line);
          parentStack(parentLine);
        }
      
        if(this["step_aside?"](indent)) {
          parentLine.children.push(line); 
        }
        
        if(this["step_out?"](indent)) {
          parentStack = parentStack.slice(0, parentStack.length + indent);
          parentLine = parentStack.last;
          parentLine.children.push(line);
        }
     
        lastLine = line;
      }
      
      return parentStack.first;
    }
    
    ,"step_in?": function(indent) {
      return indent === 1;
    }
    
    ,"step_out?": function(indent) {
      return indent < 0;
    }
    
    ,"step_aside?": function(indent) {
      return indent === 0;
    }
  }
};

jQuery.extend(Fold.Precompiler.prototype, Fold.FoldFactory);

Fold.Engine = function(source) {
  this.source = source;
};

Fold.Engine.prototype = {
  lines: function() { 
    var lines = source.split(/\n/), withoutEmpty = []
      ,i ,length = lines.length;
    
    for(i=0; i<length; i++)
      if(!lines[i].match(/^[ |\t|\n]+$/))
        withoutEmpty.push(lines[i]);
    return withoutEmpty;
  }
};