module Cymen
  def Cymen.a value
    @value = value
    puts "a @value: " + @value.to_s
  end

  def Cymen.b
    puts "b @value: " + @value.to_s
  end
end
