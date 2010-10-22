class Array

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
  def merge(array, options = {})
    strict = options[:strict]
    exclude = options[:exclude] || []
    list = array.dup
    for value in list
      array.delete(value) and next if include?(value) or exclude.include?(value)
      position = nil
      if found = merging_predecessor(value, list)
        position = index(found) + 1
      elsif found = merging_follower(value, list)
        position = index(found)
      end
      if position or !strict
        insert(position || length, value)
        array.delete(value)
      end
    end
    self
  end

  def merge_nested(array)
    combined = self.dup
    append = []
    array.each_with_index do |a,i|
      source = a.dup
      combined.each_with_index do |c,j|
        break if source.empty?
        existing = combined.flatten_once - c
        combined[j] = c.merge(source, :strict => true, :exclude => existing)
      end
      if source.any?
        combined[i] ? combined[i].concat(source) : combined.last.concat(source)
      end
    end
    combined
  end

  def flatten_with_boundaries(options = {})
    prefix = options[:prefix] || "__a"
    i = -1
    inject([]) do |v,e|
      if e.is_a?(Array)
        i += 1
        k = "#{prefix}#{i}"
        v << k
        v.concat(e)
        v << k
      else
        v << e
      end
    end
  end

  def convert_boundaries(options = {})
    prefix = options[:prefix] || "__a"
    i = 0
    boundaries = select {|a| a.match(/#{prefix}\d+/) if a.is_a?(String)}
    return self unless boundaries.any?
    array = self.dup
    converted = []
    for boundary in boundaries.uniq
      converted.concat(array.slice!(0, array.index(boundary)))
      array.shift
      converted << array.slice!(0, array.index(boundary))
      array.shift
    end
    converted.concat(array)
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
