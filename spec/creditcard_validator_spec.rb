require_relative '../lib/creditcard_validator'

describe 'CreditcardValidator' do

  context 'valid input' do
    it 'VISA' do
      expect CreditcardValidator.call('4111111111119').to eq 'VISA: 4111111111111111 (valid)'
      expect CreditcardValidator.call('4111111111111111').to eq 'VISA: 4111111111111111 (valid)'
      expect CreditcardValidator.call('4012888888881881').to eq 'VISA: 4012888888881881 (valid)'
    end
    it('AMEX')       { expect CreditcardValidator.call('378282246310005').to eq 'AMEX: 378282246310005 (valid)' }
    it('Discover')   { expect CreditcardValidator.call('6011111111111117').to eq 'Discover: 6011111111111117 (valid)' }
    it('MasterCard') { expect CreditcardValidator.call('5105105105105100').to eq 'MasterCard: 5105105105105100 (valid)' }
  end

  context 'invalid input' do
    it('VISA')       { expect ( CreditcardValidator.call('4111111111111') ).to eq 'VISA: 4111111111111 (invalid)' }
    it('MasterCard') { expect ( CreditcardValidator.call('5105105105105106') ).to eq 'MasterCard: 5105105105105106 (invalid)' }
    it('Unknown')    { expect ( CreditcardValidator.call('9111111111111111') ).to eq 'Unknown: 9111111111111111 (invalid)' }
  end

  context 'really crappy input' do
    it('no input')       { expect {CreditcardValidator.call('')}.to raise_error(InvalidInput) }
    it('character data') { expect {CreditcardValidator.call('abcdefghihk')}.to raise_error(InvalidInput) }
    it('other data')     { expect {CreditcardValidator.call('-3.1415926')}.to raise_error(InvalidInput) }
  end

end
