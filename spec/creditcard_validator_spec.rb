require File.expand_path(File.dirname(__FILE__) + '../../lib/creditcard_validator.rb')

describe 'CreditcardValidator' do

  context 'valid number' do
    describe 'VISA' do
      it ('valid leading white space') { expect(CreditcardValidator.new('  4111111111111111').call).to eq 'VISA: 4111111111111111 (valid)' }
      it ('valid trailing white space') { expect(CreditcardValidator.new('4111111111111111  ').call).to eq 'VISA: 4111111111111111 (valid)' }
      it ('valid with white space') { expect(CreditcardValidator.new('4111 1111 1111 1111').call).to eq 'VISA: 4111111111111111 (valid)' }
      it ('valid length 13') { expect(CreditcardValidator.new('4111111111119').call).to eq 'VISA: 4111111111119 (valid)' }
      it ('valid length 16') do
        expect(CreditcardValidator.new('4111111111111111').call).to eq 'VISA: 4111111111111111 (valid)'
        expect(CreditcardValidator.new('4012888888881881').call).to eq 'VISA: 4012888888881881 (valid)'
      end
    end
    describe 'AMEX' do
      it('valid 34') { expect(CreditcardValidator.new('348282246310002').call).to eq 'AMEX: 348282246310002 (valid)' }
      it('valid 37') { expect(CreditcardValidator.new('378282246310005').call).to eq 'AMEX: 378282246310005 (valid)' }
    end
    describe 'Discover' do
      it('valid') { expect(CreditcardValidator.new('6011111111111117').call).to eq 'Discover: 6011111111111117 (valid)' }
    end
    describe 'MasterCard' do
      it('valid 51') { expect(CreditcardValidator.new('5105105105105100').call).to eq 'MasterCard: 5105105105105100 (valid)' }
      it('valid 52') { expect(CreditcardValidator.new('5205105105105091').call).to eq 'MasterCard: 5205105105105091 (valid)' }
      it('valid 53') { expect(CreditcardValidator.new('5305105105105090').call).to eq 'MasterCard: 5305105105105090 (valid)' }
      it('valid 54') { expect(CreditcardValidator.new('5405105105105081').call).to eq 'MasterCard: 5405105105105081 (valid)' }
      it('valid 55') { expect(CreditcardValidator.new('5505105105105080').call).to eq 'MasterCard: 5505105105105080 (valid)' }
    end
  end

  context 'invalid number' do
    it('VISA')       { expect(CreditcardValidator.new('4111111111111').call).to eq 'VISA: 4111111111111 (invalid)' }
    it('AMEX')       { expect(CreditcardValidator.new('378282246310015').call).to eq 'AMEX: 378282246310015 (invalid)' }
    it('Disover') { expect(CreditcardValidator.new('6011111111111118').call).to eq 'Discover: 6011111111111118 (invalid)' }
    it('MasterCard') { expect(CreditcardValidator.new('5105105105105106').call).to eq 'MasterCard: 5105105105105106 (invalid)' }
    it('Unknown')    { expect(CreditcardValidator.new('9111111111111111').call).to eq 'Unknown: 9111111111111111 (invalid)' }
  end

  context 'invalid input' do
    it('no input')       { expect { CreditcardValidator.new('').call }.to raise_error(InvalidInput) }
    it('character data') { expect { CreditcardValidator.new('abcdefghihk').call }.to raise_error(InvalidInput) }
    it('other data')     { expect { CreditcardValidator.new('-3.1415926').call }.to raise_error(InvalidInput) }
  end

end