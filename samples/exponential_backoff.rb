# This sample demonstrates how exponential backoff can be layered on top of Manana
#
# run from the gem dir with: 
# $ rake samples
# $ ruby samples/exponential_backoff.rb 

require_relative 'common/samples_helper.rb'

# ------------------------- sample code starts here -------------------------

require 'manana'
require 'benchmark'


class PoorService
  @@instance = 0

  def initialize
    @@instance += 1
    if @@instance <= 3 
      raise "failed to init"
    end
    puts "successfully inited service."
  end

  def process
    puts "successfully called service!"
  end

end

# ------------ initialization code

client = Manana.wrap {
  # exponential backkoff logic in the initialization block
  retries = 0
  obj = nil

  puts "trying to create service object..."
  begin
    obj = PoorService.new
  rescue RuntimeError => e
    puts "couldn't create object, sleeping for #{2**retries} seconds before next try..."
    sleep(2**retries)
    retries += 1

    if retries <= 3
      retry
    else
      puts "giving up."
      raise e
    end
  end
  obj
}


# ------------ runtime code

client.process
client.process
client.process
client.process


