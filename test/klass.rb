class Klass
  INITIALIZE_MESSAGE   = "initialized!"
  DO_SOMETHING_MESSAGE = "I did something!"
  RAISE_MESSAGE        = "kablooey!"
  
  def self.incr
    @count ||= 0
    @count += 1
    @count
  end

  def self.count
    @count ||= 0
    @count
  end

  def self.reset 
    @count = 0
  end

  def initialize
    puts INITIALIZE_MESSAGE
  end

  def do_something
    DO_SOMETHING_MESSAGE
  end

  def raise_something
    raise RAISE_MESSAGE
  end
end