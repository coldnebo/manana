# something like ActiveRecord::Base
class BaseKlass

  def self.connected?
    @@connected ||= false
  end

  def self.establish_connection
    @@connected = true
  end

  def self.find
    raise "not connected!" unless self.connected?
    [1,2,3]
  end

end