require "core_extensions/object"
require "core_extensions/hash"
require "core_extensions/array"

Object.send :include, Vidibus::CoreExtensions::Object
Hash.send :include, Vidibus::CoreExtensions::Hash
Array.send :include, Vidibus::CoreExtensions::Array