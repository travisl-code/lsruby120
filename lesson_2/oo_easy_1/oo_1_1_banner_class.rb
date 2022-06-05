# Complete class so test cases work. Add methods/instance variables as needed. No public implementation details.

# Further Explore - modify class to optionally specify fixed banner width at instantiation; center within banner. Decide how to handle widths too narrow or wide.

class Banner
  MAX_BANNER_SIZE = 80

  def initialize(message, banner_width=nil)
    @message = message
    @padded_size = message.size + 2
    @banner_width = banner_width
  end

  def to_s
    bannerize
  end

  private
  attr_reader :message, :banner_width
  attr_accessor :padded_size

  def bannerize
    case banner_width <=> padded_size - 2
    when -1
      return "Provided banner size is too small!"
    when 0
      self.padded_size -= 2
      make_banner
    when 1
      return "Provided banner size is too large" if banner_width > MAX_BANNER_SIZE
      self.padded_size = banner_width + 2
      make_banner
    else
      make_banner
    end
  end

  def make_banner
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  def horizontal_rule
    "+#{'-' * padded_size}+"
  end

  def empty_line
    "|#{' ' * padded_size}|"
  end

  def message_line
    "|#{message.center(padded_size)}|"
  end
end

banner1 = Banner.new('To boldly go where no one has gone before.', 60)
puts banner1
banner2 = Banner.new('')
puts banner2
