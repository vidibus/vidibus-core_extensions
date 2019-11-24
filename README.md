# Vidibus::CoreExtensions [![Build Status](https://travis-ci.org/vidibus/vidibus-core_extensions.png)](https://travis-ci.org/vidibus/vidibus-core_extensions)

It provides some extensions to the ruby core.


## Installation

Add `gem "vidibus-core_extensions"` to your Gemfile. Then call `bundle install` on your console.


# Usage

## Array

### Array#flatten_once

Flattens first level of an array. Example:
```ruby
[1, [2, [3]]].flatten_once  # => [1, 2, [3]]
```

### Array#merge

Merges given array with current one.

It will perform insertion of new items by three rules:

1. If the item's predecessor is present, insert item after it.
2. If the item's follower is present, insert item before it.
3. Insert item at end of list.

Examples:

```ruby
[].merge([1, 2])            # => [1, 2]
['a'].merge([1, 2])         # => ['a', 1, 2]
[1, 'a'].merge([1, 2])      # => [1, 2, 'a']
[1, 'a'].merge([3, 1, 2])   # => [3, 1, 2, 'a']
```

## Hash

### Hash#to_uri

Returns URL-encoded string of uri params. Examples:

```ruby
{:some => :value, :another => "speciál"}.to_uri  # => "some=value&another=speci%C3%A1l"
{:some => {:nested => :thing}}.to_uri            # => "some[nested]=thing"
```

### Hash#only

Returns a copy of self including only the given keys. Example:

```ruby
{:name => "Rodrigo", :age => 21}.only(:name)  # => {:name => "Rodrigo"}
```

### Hash#except

Returns a copy of self including all but the given keys. Example:

```ruby
{:name => "Rodrigo", :age = 21}.except(:name)  # => {:age => 21}
```

## String

### String#latinize

Returns a string without exotic chars. Examples:

```ruby
"Hola señor, ¿cómo está?".latinize # => "Hola senor, como esta?"
"Ähre, wem Ähre gebührt.".latinize # => "AEhre, wem AEhre gebuehrt."
```

### String#permalink

Returns a string that may be used as permalink. Example:

```ruby
"Hola señor, ¿cómo está?".permalink # => "hola-senor-como-esta"
```

## Copyright

Copyright (c) 2010-2019 Andre Pankratz. See LICENSE for details.
