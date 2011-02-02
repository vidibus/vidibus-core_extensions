require "fileutils"

module FileUtils

  # Removes the current directory recursively including
  # all empty parent directories up to given depth.
  # The current directory will be removed with all its contents,
  # but parent directories will only be removed if empty.
  #
  # Example:
  #
  #   FileUtils.remove_dir_r("/my/nice/private/dir", 2)
  #   # will remove dir and, if empty, private as well
  #
  def self.remove_dir_r(dir, max_depth = 3)
    FileUtils.remove_dir(dir)
    parts = dir.split("/")
    while max_depth > 1
      parts.pop
      max_depth -= 1
      folder = File.join(parts)
      break if (Dir.entries(folder) - ['.', '..']).any?
      FileUtils.remove_dir(folder)
    end
  end
end
