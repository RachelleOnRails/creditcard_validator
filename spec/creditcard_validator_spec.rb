require File.expand_path(File.dirname(__FILE__) + '../../lib/creditcard_validator.rb')

describe 'CreditcardValidator' do

  context 'valid number' do
    it 'VISA' do
      valid_number_1 = CreditcardValidator.new('4111111111119')
      expect(valid_number_1.call).to eq 'VISA: 4111111111119 (valid)'
      valid_number_2 = CreditcardValidator.new('4111111111111111')
      expect(valid_number_2.call).to eq 'VISA: 4111111111111111 (valid)'
      valid_number_3 = CreditcardValidator.new('4012888888881881')
      expect(valid_number_3.call).to eq 'VISA: 4012888888881881 (valid)'
    end
    it 'AMEX' do
      valid_number_4 = CreditcardValidator.new('378282246310005')
      expect(valid_number_4.call).to eq 'AMEX: 378282246310005 (valid)'
    end
    it 'Discover' do
      valid_number_5 = CreditcardValidator.new('6011111111111117')
      expect(valid_number_5.call).to eq 'Discover: 6011111111111117 (valid)'
    end
    it 'MasterCard' do
      valid_number_6 = CreditcardValidator.new('5105105105105100')
      expect(valid_number_6.call).to eq 'MasterCard: 5105105105105100 (valid)'
    end
  end

  context 'invalid number' do
    it 'VISA' do
      invalid_number_1 = CreditcardValidator.new('4111111111111')
      expect(invalid_number_1.call).to eq 'VISA: 4111111111111 (invalid)'
    end
    it 'MasterCard' do
      invalid_number_2 = CreditcardValidator.new('5105105105105106')
      expect(invalid_number_2.call).to eq 'MasterCard: 5105105105105106 (invalid)'
      # expect (CreditcardValidator.call('5105105105105106')).to eq 'MasterCard: 5105105105105106 (invalid)'
    end
    it 'Unknown' do
      invalid_number_3 = CreditcardValidator.new('9111111111111111')
      expect(invalid_number_3.call).to eq 'Unknown: 9111111111111111 (invalid)'
    end
  end

  context 'invalid input' do
    it('no input') do
      invalid_input_1 = CreditcardValidator.new('')
      expect { invalid_input_1.call }.to raise_error(InvalidInput)
    end
    it('character data') do
      invalid_input_2 = CreditcardValidator.new('abcdefghihk')
      expect { invalid_input_2.call }.to raise_error(InvalidInput)
    end
    it('other data') do
      invalid_input_3 = CreditcardValidator.new('-3.1415926')
      expect { invalid_input_3.call }.to raise_error(InvalidInput)
    end
  end

end