require "uri"

module Vidibus
  module CoreExtensions
    module Hash
      module ClassMethods
        
        # Returns new hash with given arguments.
        # If an array is provided, it will be flattened once. Multi-level arrays are not supported.
        # This method is basically a helper to support different return values of Hash#select:
        # Ruby 1.8.7 returns an array, Ruby 1.9.2 returns a hash.
        # 
        def build(args = nil)
          if args.is_a?(::Array)
            args = args.flatten_once
            ::Hash[*args]
          elsif args.is_a?(::Hash)
            args
          else
            ::Hash.new
          end
        end
      end
      
      module InstanceMethods

        # Returns URL-encoded string of uri params.
        # 
        # Examples:
        #  
        #  { :some => :value, :another => "speciál" }.to_uri  # => "some=value&another=speci%C3%A1l"
        #  { :some => { :nested => :thing } }.to_uri          # => "some=[nested=thing]"
        #
        def to_uri
          list = self.to_a.map do |arg|
            value = arg[1]
            if value.is_a?(::Hash)
              value = "[#{value.to_uri}]"
            else
              value = URI.escape(value.to_s)
            end
            "#{URI.escape(arg[0].to_s)}=#{value}"
          end
          list.join("&")
        end
      
        # Returns a copy of self including only the given keys.
        #
        # Example:
        #
        #   { :name => "Rodrigo", :age => 21 }.only(:name)  # => { :name => "Rodrigo" }
        #
        # Inspired by: 
        # http://www.koders.com/ruby/fid80243BF76758F830B298E0E681B082B3408AB185.aspx?s=%22Rodrigo+Kochenburger%22#L9
        # and
        # http://snippets.dzone.com/posts/show/302
        #
        def only(*keys)
          keys.flatten!
          args = self.select { |k,v| keys.include?(k) }
          ::Hash.build(args)
        end

        # Returns a copy of self including all but the given keys.
        #
        # Example:
        #
        #   { :name => "Rodrigo", :age = 21 }.except(:name)  # => { :age => 21 }
        #
        # Inspired by: 
        # http://www.koders.com/ruby/fid80243BF76758F830B298E0E681B082B3408AB185.aspx?s=%22Rodrigo+Kochenburger%22#L9
        #
        def except(*keys)
          keys.flatten!
          args = self.select { |k,v| !keys.include?(k) }
          ::Hash.build(args)
        end
        
        # Returns a nested array. Just like #to_a, but nested.
        #
        def to_a_rec
          array = []
          for key, value in self
            value = value.to_a_rec.first if value.is_a?(::Hash)
            array << [key, value]
          end
          array
        end
      end
    end
  end
end
