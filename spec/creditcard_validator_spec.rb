require_relative '../lib/creditcard_validator'

describe 'creditcard_validator' do

  context 'valid input' do
    it 'VISA' do
      expect(creditcard_validator.call('4111111111111111')).to eq('VISA: 4111111111111111 (valid)')
      expect(creditcard_validator.call('4012888888881881')).to eq('VISA: 4012888888881881 (valid)')
    end
    it 'AMEX' do
      expect(creditcard_validator.call('378282246310005')).to eq('AMEX: 378282246310005 (valid)')
    end
    it 'Discover' do
      expect(creditcard_validator.call('6011111111111117')).to eq('Discover: 6011111111111117 (valid)')
    end
    it 'MasterCard' do
      expect(creditcard_validator.call('5105105105105100')).to eq('MasterCard: 5105105105105100 (valid)')
    end
  end

  context 'invalid input' do
    it 'VISA' do
      expect(creditcard_validator.call('4111111111111')).to eq('VISA: 4111111111111 (invalid)')
    end
    it 'MasterCard' do
      expect(creditcard_validator.call('5105105105105106')).to eq('MasterCard: 5105105105105106 (invalid)')
    end
    it 'Unknown' do
      expect(creditcard_validator.call('9111111111111111')).to eq('Unknown: 9111111111111111 (invalid)')
    end
  end

  context 'really crappy input' do
    it('no input') { expect(creditcard_validator.call('')).to raise_error(InvalidInput) }
    it('character data') { expect(creditcard_validator.call('abcdefghihk')).to raise_error(InvalidInput) }
    it('other data') { expect(creditcard_validator.call('-3.1415926')).to raise_error(InvalidInput) }
  end

end
