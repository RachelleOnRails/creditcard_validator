class InvalidInput < StandardError
end

class CreditcardValidator

  def self.valid_input?(input)
    input.to_s[/^[0-9]\d*$/]
  end

  def self.call(number)
    if valid_input? number
      puts "#{number} is valid"
    else
      raise InvalidInput
    end
  end

  def self.get_input
    puts "Enter a credit card number: "
    STDOUT.flush
    gets.chomp
  end

end

if __FILE__ == $0
  n = CreditcardValidator.get_input
  begin
    CreditcardValidator.call(n)
  rescue InvalidInput
    puts "Invalid input. Only numbers are accepted."
  end
end
