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

  def self.single_digitise(number)
    if number > 9
      number/10 + number%10
    else
      number
    end
  end

  def self.valid_number?(number, card_type)
    if card_type == 'Unknown'
      false
    else
      # 1. remove the last digit to use as a check value
      # 2. reverse the numbers
      # 3. double each odd-numbered entry in the array
      # 4. convert to a single digit
      # 5. cumulatively add these single digits
      # 6. multiply that cumulative total by 9
      # 7. take the last digit of that product
      # 8. compare it to the check value taken in step 1

      check_digit = number[-1]

      sum = 0
      number.chop.reverse.split("").each_with_index do |digit,index|
        digit = digit.to_i
        if (index+1).odd?
          sum += single_digitise(digit*2)
        else
          sum += digit
        end
      end
      (sum * 9).to_s[-1] == check_digit
    end
  end

  def self.call(number)
    if valid_input? number
      card_type = card_type(number)
      valid = valid_number?(number, card_type)
      puts "#{card_type}: #{number} (#{valid})"
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
