require "core_extensions/hash"
require "core_extensions/array"

Hash.send :include, Vidibus::CoreExtensions::Hash
Array.send :include, Vidibus::CoreExtensions::Array