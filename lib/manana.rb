require "manana/version"

class Manana
  attr_reader :deferred_initialization, :instance

  def self.wrap(&block)
    Manana.new(&block)
  end 

  def method_missing(method, *args, &block)
    instance = get_instance
    instance.send(method, *args, &block);
  end

  private

  def initialize(&block)
    @deferred_initialization = block
  end

  def get_instance
    if @instance.nil?
      @instance = @deferred_initialization.call
    end
    @instance
  end


end
