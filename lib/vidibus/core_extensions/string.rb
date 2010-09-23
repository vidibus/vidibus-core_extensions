# encoding: utf-8
class String

  # Map of latin chars and their representations as unicode chars.
  LATIN_MAP = {
    "A"  => %w[À Á Â Ã Å Ą Ā],
    "a"  => %w["à á â ã å ą ả ã ạ ă ắ ằ ẳ ẵ ặ â ấ ầ ẩ ẫ ậ ā],
    "AE" => %w[Ä Æ Ǽ],
    "ae" => %w[ä æ ǽ],
    "C"  => %w[Ç Č Ć Ĉ],
    "c"  => %w[ç č ć ĉ],
    "D"  => %w[Ð],
    "d"  => %w[đ],
    "E"  => %w[È É Ê Ẽ Ę Ė Ē Ë],
    "e"  => %w[è é ę ë ė ẻ ẽ ẹ ê ế ề ể ễ ệ ē],
    "G"  => %w[Ģ],
    "g"  => %w[ģ],
    "I"  => %w[Ì Í Î Ï Ĩ Į Ī],
    "i"  => %w[ì í î ï ĩ į ỉ ị ī],
    "K"  => %w[Ķ],
    "k"  => %w[ķ],
    "L"  => %w[Ļ],
    "l"  => %w[ļ],
    "N"  => %w[Ñ Ń Ņ],
    "n"  => %w[ñ ń ņ],
    "O"  => %w[Ò Ó Ô Õ Ø],
    "o"  => %w[ò ó õ ỏ õ ọ ô ố ồ ổ ỗ ộ ơ ớ ờ ở ỡ ợ ø],
    "OE" => %w[Ö Œ],
    "oe" => %w[ö œ],
    "R"  => %w[Ŗ],
    "r"  => %w[ŗ],
    "S"  => %w[Š],
    "s"  => %w[š],
    "ss" => %w[ß],
    "U"  => %w[Ù Ú Ũ Ű Ů Ũ Ų Ū Û],
    "u"  => %w[ų ū û ú ù ű ů ủ ũ ụ ư ứ ừ ử ữ ự],
    "UE" => %w[Ü],
    "ue" => %w[ü],
    "x"  => %w[×],
    "Y"  => %w[Ý Ÿ Ŷ],
    "y"  => %w[ý ÿ ŷ ỳ ỷ ỹ ỵ],
    "Z"  => %w[Ž],
    "z"  => %w[ž]
  }.freeze

  # Replaces non-latin chars, leaves some special ones.
  def latinize
    c = clone
    for char, map in LATIN_MAP
      c.gsub!(/(#{map.join('|')})/, char)
    end
    c.gsub(/[^a-z0-9\.\,\|\?\!\:;"'=\+\-_]+/i, " ").
      gsub(/ {2,}/, " ")
  end

  # Returns a string that may be used as permalink
  def permalink
    latinize.
      downcase.
      gsub(/[^a-z0-9]+/, "-").
      gsub(/^-/, "").gsub(/-$/, "")
  end

  # Extends Kernel::sprintf to accept "named arguments" given as hash.
  # This method was taken from Ruby-GetText. Thank you!
  #
  # Examples:
  #
  #  # Normal sprintf behaviour:
  #  "%s, %s" % ["Masao", "Mutoh"]
  #
  #  # Extended version with named arguments:
  #  "%{firstname}, %{familyname}" % {:firstname => "Masao", :familyname => "Mutoh"}
  #
  alias :_sprintf :% # :nodoc:
  def %(args)
    if args.kind_of?(Hash)
      ret = dup
      args.each do |key, value|
        ret.gsub!(/\%\{#{key}\}/, value.to_s)
      end
      ret
    else
      ret = gsub(/%\{/, '%%{')
      begin
        ret._sprintf(args)
      rescue ArgumentError
        $stderr.puts "  The string:#{ret}"
        $stderr.puts "  args:#{args.inspect}"
      end
    end
  end
end
