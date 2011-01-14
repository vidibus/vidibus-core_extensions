require "uri"

class Hash

  # Returns new hash with given arguments.
  # If an array is provided, it will be flattened once. Multi-level arrays are not supported.
  # This method is basically a helper to support different return values of Hash#select:
  # Ruby 1.8.7 returns an array, Ruby 1.9.2 returns a hash.
  #
  def self.build(args = nil)
    if args.is_a?(::Array)
      args = args.flatten_once
      self[*args]
    elsif args.is_a?(self)
      args
    else
      self.new
    end
  end

  # Returns URL-encoded string of uri params.
  #
  # Examples:
  #
  #  {:some => :value, :another => "speciál"}.to_uri  # => "some=value&another=speci%C3%A1l"
  #  {:some => {:nested => :thing}}.to_uri            # => "some[nested]=thing"
  #
  # Stolen from active_record/core_ext. Thanks
  #
  def to_query(namespace = nil)
    out = collect do |key, value|
      value.to_query(namespace ? "#{namespace}[#{key}]" : key)
    end.sort * "&"
  end
  alias_method :to_uri, :to_query

  # Returns a copy of self including only the given keys.
  #
  # Example:
  #
  #   {:name => "Rodrigo", :age => 21}.only(:name)  # => {:name => "Rodrigo"}
  #
  # Inspired by:
  # http://www.koders.com/ruby/fid80243BF76758F830B298E0E681B082B3408AB185.aspx?s=%22Rodrigo+Kochenburger%22#L9
  # and
  # http://snippets.dzone.com/posts/show/302
  #
  def only(*keys)
    keys.flatten!
    args = self.select { |k,v| keys.include?(k) }
    Hash.build(args)
  end

  # Returns a copy of self including all but the given keys.
  #
  # Example:
  #
  #   {:name => "Rodrigo", :age = 21}.except(:name)  # => {:age => 21}
  #
  # Inspired by:
  # http://www.koders.com/ruby/fid80243BF76758F830B298E0E681B082B3408AB185.aspx?s=%22Rodrigo+Kochenburger%22#L9
  #
  def except(*keys)
    keys.flatten!
    args = self.select { |k,v| !keys.include?(k) }
    Hash.build(args)
  end

  # Returns a nested array. Just like #to_a, but nested.
  # Also converts hashes within arrays.
  #
  def to_a_rec
    array = []
    for key, value in self
      if value.is_a?(Hash)
        value = value.to_a_rec
      elsif value.is_a?(Array)
        a = value.flatten
        value = []
        for v in a
          value << (v.is_a?(Hash) ? v.to_a_rec : v)
        end
      end
      array << [key, value]
    end
    array
  end


  # Returns true if hash has all of given keys.
  # It's like Hash#key?, but it accepts several keys.
  #
  # Example:
  #
  #  {:some => "say", :any => "thing"}.keys?(:some, :any) # => true
  #
  def keys?(*args)
    for arg in args
      return false unless self[arg]
    end
    return true
  end
end
