require 'price'

describe 'Convert Arabic to Roman Numerals' do
  context 'The Romans didnt have a representation of zero' do
    it 'converts zero to a blank string' do
      expect(convert(0)).to eq('')
    end
  end
    
  { 1 => 'I',
    2 => 'II',
    3 => 'III',
    55 => 'LV',
    3497 => 'MMMCDXCVII'
  }.each_pair do |arabic, roman|
      it "converts #{arabic} to #{roman}" do
        expect(convert(arabic)).to eq(roman)
      end
  end
  
  it "converts 3497 to #{convert(3497)}" do
  end
  
end