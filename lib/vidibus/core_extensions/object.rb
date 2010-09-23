class Object

  # Tries to use a method on object.
  #
  # Example:
  #   something.try!(:else) # => nil
  #
  def try!(method)
    begin
      send(method)
    rescue
    end
  end
end
