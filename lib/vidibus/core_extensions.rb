require "core_extensions/object"
require "core_extensions/hash"
require "core_extensions/array"
require "core_extensions/string"

Object.send :include, Vidibus::CoreExtensions::Object
Hash.send :extend, Vidibus::CoreExtensions::Hash::ClassMethods
Hash.send :include, Vidibus::CoreExtensions::Hash::InstanceMethods
Array.send :include, Vidibus::CoreExtensions::Array
