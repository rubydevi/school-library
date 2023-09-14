require_relative '../app_code/teacher'

describe Teacher do
  let(:teacher) { Teacher.new(36, 'Maths', 'Supreeti', parents_permission: true) }
  let(:specialization) { double('Specialization') } # Creating a mock specialization

  describe '#initialize' do
    it 'creates a new Teacher instance with the given attributes' do
      expect(teacher.age).to eq(36)
      expect(teacher.specialization).to eq('Maths')
      expect(teacher.name).to eq('Supreeti')
      expect(teacher.parents_permission).to be_truthy
      expect(teacher.type).to eq('Teacher')
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to eq(true)
    end
  end
end
