require_relative '../app_code/trimmer_decorator'
require_relative '../app_code/capitalize_decorator'
require_relative '../app_code/person'

describe TrimmerDecorator do
  before(:each) do
    @person = Person.new(33, 'Supreetikushwaha')
    @capitalize = CapitalizeDecorator.new(@person)
    @trimmer = TrimmerDecorator.new(@capitalize)
  end

  describe 'It trims the name of the person' do
    it 'Trims to 10 character' do
      expect(@trimmer.correct_name).to eq('Supreetiku')
    end
  end
end
