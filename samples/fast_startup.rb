# This sample demonstrates how Manana may be used to defer a long initialization 
# to the first method call.
#
# run from the gem dir with: 
# $ rake samples
# $ ruby samples/fast_startup.rb 

require_relative 'common/samples_helper.rb'

# ------------------------- sample code starts here -------------------------

require 'manana'
require 'benchmark'


class DeathStar

  def initialize
    puts "  DeathStar initialization sequence commencing..."
    super_complex_startup_sequence
    puts "  ...sequence complete."
  end

  def navigate_to(planet)
    puts "setting course for the planet '#{planet}'"
  end

  private

  def super_complex_startup_sequence
    puts "    1. press the 'start' button."
    puts "    2. snooze while Vader isn't looking."
    sleep(5)
    puts "    3. ???"
    puts "    4. profit!"
  end

end

# ------------ initialization code

mini_death_star = nil

puts "[Vader]: requisition a new DeathStar and make it snappy!"
# boss said requisitions have to be faster*!  Manana to the rescue!
puts Benchmark.measure {
  mini_death_star = Manana.wrap {
    DeathStar.new
  }
}
puts "[Expendable Commander]: completed, sir!"


puts "-------------------------------------------"


# ------------ runtime code

puts "[Vader]: ok, send it towards some rebels..."

# * this first method eats the hidden startup cost... 
puts Benchmark.measure { 
  mini_death_star.navigate_to("Yavin")
}
puts "[Vader raises an eyebrow and starts to reach towards the commander] \n# first method call was long, but subsequent calls are faster..."

# * subsequent method calls are fast though... maybe tradeoff is good enough for Vader?
puts Benchmark.measure { 
  mini_death_star.navigate_to("Bespin")
}

puts Benchmark.measure { 
  mini_death_star.navigate_to("Tatooine")
}

puts "[Vader shrugs]: Well done Expendable Commander!"
puts "[Expendable Commander sweatly profusely]: Thank you Lord Vader!"






