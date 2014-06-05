class InvalidInput < StandardError
end

class CreditcardValidator

  def self.valid_input?(input)
    input.to_s[/^[0-9]\d*$/]
  end

  def self.visa?
    (@number.length == 13 || @number.length == 16) && @number.start_with?('4')
  end

  def self.amex?
    @number.length == 15 && (@number.start_with?('34') || @number.start_with?('37'))
  end

  def self.discover?
    @number.length == 16 && @number.start_with?('6011')
  end

  def self.mastercard?
    @number.length == 16 &&
        (@number.start_with?('51') || @number.start_with?('52') || @number.start_with?('53') || @number.start_with?('54') || @number.start_with?('55'))
  end

  def self.card_type
    if visa?
      'VISA'
    elsif amex?
      'AMEX'
    elsif discover?
      'Discover'
    elsif mastercard?
      'MasterCard'
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

  def self.valid_number?
    if @card_type == 'Unknown'
      false
    else
      # 1. reverse the numbers
      # 2. double the second and every other entry in the array
      # 3. convert to a single digit
      # 4. cumulatively add these single digits
      # 5. if this sum is a multiple of 10 then the number is valid

      sum = 0
      @number.reverse.split("").each_with_index do |digit,index|
        digit = digit.to_i
        if (index).odd?
          sum += single_digitise(digit*2)
        else
          sum += digit
        end
      end
      sum % 10 == 0
    end
  end

  def self.call(number)
    if valid_input? number
      @number = number
      @card_type = card_type
      if valid_number?
        valid = 'valid'
      else
        valid = 'invalid'
      end
      puts "#{@card_type}: #{@number} (#{valid})"
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
