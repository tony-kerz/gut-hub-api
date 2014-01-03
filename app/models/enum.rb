class Enum
  def self.keys
    constants
  end

  def self.values
    @values ||= constants.map { |const| const_get(const) }
  end
end