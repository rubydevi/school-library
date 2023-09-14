require_relative '../app_code/capitalize_decorator'
require_relative '../app_code/person'

describe CapitalizeDecorator do
  before(:each) do
    @person = Person.new(33, 'supreeti')
    @capitalize = CapitalizeDecorator.new(@person)
  end

  describe 'It Capitalizes the name of the person' do
    it 'Capitalize first letter of the given name' do
      expect(@capitalize.correct_name).to eq('Supreeti')
    end
  end
end
