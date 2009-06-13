# Cookie cutter code from ActiveRecord::Callbacks
module CollectiveIdea #:nodoc:
  module Acts #:nodoc:
    module NestedSet #:nodoc:
      module Callbacks
        CALLBACKS = %w(before_move after_move)
        
        def self.included(base) #:nodoc:
          base.extend Observable
          base.send :alias_method_chain, :move_to, :callbacks
          base.send :include, ActiveSupport::Callbacks
          base.define_callbacks *CALLBACKS
        end
        
        # Is called _before_ <tt>move_to</tt>
        def before_move() end
        
        # Is called _after_ <tt>move_to</tt>
        def after_move()  end
        def move_to_with_callbacks #:nodoc:
          return false if callback(:before_save) == false
          if result = move_to_without_callbacks
            callback(:after_move)
          end
          result
        end
      end
    end
  end
end