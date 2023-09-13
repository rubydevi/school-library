require_relative '../app_code/nameable'

describe Nameable do
  let(:nameable) { Nameable.new }

  describe '#correct_name' do
    it 'raises NotImplementedError' do
      expect do
        nameable.correct_name
      end.to raise_error(NotImplementedError, 'The method \'correct_name\' is not implemented.')
    end
  end
end
