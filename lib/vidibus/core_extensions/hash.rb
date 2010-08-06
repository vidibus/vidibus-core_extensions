require "uri"

module Vidibus
  module CoreExtensions
    module Hash

      # Returns URL-encoded string of uri params.
      # 
      # Usage:
      #  
      #  hash = { :some => :value, :another => "speciál" }
      #  hash.to_uri # => "some=value&another=speci%C3%A1l"
      #
      #  hash = { :some => { :nested => :thing } }
      #  hash.to_uri # => "some=[nested=thing]"
      #
      def to_uri
        self.to_a.map do |arg|
          value = arg[1]
          if value.is_a?(Hash)
            value = "[#{value.to_uri}]"
          else
            value = URI.escape(value.to_s)
          end
          "#{URI.escape(arg[0].to_s)}=#{value}"
        end.join("&")
      end
      
      # Returns a copy of self but including only the given keys.
      #
      # Usage:
      #
      #   hash = { :name => "rodrigo", :age => 21 }
      #   hash.only(:name)  # => { :name => "rodrigo" }
      #
      # Inspired by: http://www.koders.com/ruby/fid80243BF76758F830B298E0E681B082B3408AB185.aspx?s=%22Rodrigo+Kochenburger%22#L9
      #              http://snippets.dzone.com/posts/show/302
      #
      def only(*keys)
        keys.flatten!
        self.class[*self.select { |k,v| keys.include?(k) }.flatten_once]
      end

      # Returns a copy of self including all but the given keys.
      #
      # Usage:
      #
      #   hash = { :name => "rodrigo", :age = 21 }
      #   hash.except(:name)  # => { :age => 21 }
      #
      # Thank you: http://www.koders.com/ruby/fid80243BF76758F830B298E0E681B082B3408AB185.aspx?s=%22Rodrigo+Kochenburger%22#L9
      #
      def except(*keys)
        keys.flatten!
        self.class[*self.select { |k,v| !keys.include?(k) }.flatten_once]
      end
    end
  end
end