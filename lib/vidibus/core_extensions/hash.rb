require "uri"

module Vidibus
  module CoreExtensions
    module Hash

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
          if value.is_a?(Hash)
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
        self.class[*self.select { |k,v| keys.include?(k) }.flatten_once]
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
        self.class[*self.select { |k,v| !keys.include?(k) }.flatten_once]
      end
    end
  end
end