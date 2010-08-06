module Vidibus
  module CoreExtensions
    module Array
      
      # Flattens first level.
      # Inspired by: http://snippets.dzone.com/posts/show/302#comment-1417
      def flatten_once
        inject([]) do |v,e|
          if e.is_a?(Array)
            v.concat(e)
          else
            v << e
          end
        end
      end
    end
  end
end