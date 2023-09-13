require_relative '../app_code/decorator'

describe Decorator do
  let(:nameable) { double('Nameable') }
  let(:decorator) { Decorator.new(nameable) }

  describe '#correct_name' do
    it 'calls correct_name on the wrapped Nameable' do
      expect(nameable).to receive(:correct_name)
      decorator.correct_name
    end
  end
end
