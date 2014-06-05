class InvalidInput < StandardError
end

class CreditcardValidator

  def self.valid_input?(input)
    input.to_s[/^[0-9]\d*$/]
  end

  # +============+=============+===============+
  # | Card Type  | Begins With | Number Length |
  # +============+=============+===============+
  # | AMEX       | 34 or 37    | 15            |
  # +------------+-------------+---------------+
  # | Discover   | 6011        | 16            |
  # +------------+-------------+---------------+
  # | MasterCard | 51-55       | 16            |
  # +------------+-------------+---------------+
  # | Visa       | 4           | 13 or 16      |
  # +------------+-------------+---------------+
  def self.card_type(number)
    case number.length
      when 13
        if number.start_with?('4')
          'VISA'
        else
          'Unknown'
        end
      when 15
        if number.start_with?('34') || number.start_with?('37')
          'AMEX'
        else
          'Unknown'
        end
      when 16
        if number.start_with?('6011')
          'Discover'
        elsif number.start_with?('51') || number.start_with?('52') || number.start_with?('53') || number.start_with?('54') || number.start_with?('55')
          'MasterCard'
        elsif number.start_with?('4')
          'VISA'
        else
          'Unknown'
        end
      else
        'Unknown'
    end
  end

  def self.call(number)
    if valid_input? number
      card_type = card_type(number)
      puts "card type is #{card_type}"
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
