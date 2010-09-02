module Vidibus
  module CoreExtensions
    module Array
      
      # Flattens first level.
      #
      # Example:
      #  
      #   [1, [2, [3]]].flatten_once  # => [1, 2, [3]]
      #
      # Inspired by: http://snippets.dzone.com/posts/show/302#comment-1417
      #
      def flatten_once
        inject([]) do |v,e|
          if e.is_a?(Array)
            v.concat(e)
          else
            v << e
          end
        end
      end
      
      # Merges given array with current one.
      #
      # Will perform insertion of new items by three rules:
      # 1. If the item's predecessor is present, insert item after it.
      # 2. If the item's follower is present, insert item before it.
      # 3. Insert item at end of list.
      #
      # Examples:
      #
      #   [].merge([1, 2])            # => [1, 2]
      #   ['a'].merge([1, 2])         # => ['a', 1, 2]
      #   [1, 'a'].merge([1, 2])      # => [1, 2, 'a']
      #   [1, 'a'].merge([3, 1, 2])   # => [3, 1, 2, 'a']
      # 
      def merge(array)
        for value in array
          next if include?(value)
          if found = merging_predecessor(value, array)
            position = index(found) + 1
          elsif found = merging_follower(value, array)
            position = index(found)
          end
          insert(position || length, value)
        end
        self
      end
      
      private
      
      # Returns predecessor of given needle from haystack.
      # Helper method for #merge
      def merging_predecessor(needle, haystack)
        list = haystack[0..haystack.index(needle)].reverse
        (list & self).first
      end

      # Returns follower of given needle from haystack.
      # Helper method for #merge
      def merging_follower(needle, haystack)
        list = haystack[haystack.index(needle)+1..-1]
        (list & self).first
      end
    end
  end
end
