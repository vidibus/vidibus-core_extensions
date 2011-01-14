class Object

  # Tries to use a method on object.
  #
  # Example:
  #   something.try!(:else) # => nil
  #
  def try!(method)
    begin
      send(method)
    rescue NoMethodError
    rescue => e
      raise e
    end
  end

  # Turns object into a key-value pair.
  # Stolen from active_support/core_ext
  def to_query(key)
    require "cgi" unless defined?(CGI) && defined?(CGI::escape)
    "#{CGI.escape(key.to_s)}=#{CGI.escape(to_s)}"
  end
end
