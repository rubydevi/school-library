require_relative '../app_code/student'

describe Student do
  let(:student) { Student.new(16, 'Alice', parents_permission: true) }
  let(:classroom) { double('Classroom') }

  describe '#initialize' do
    it 'creates a new Student instance with the given attributes' do
      expect(student.age).to eq(16)
      expect(student.name).to eq('Alice')
      expect(student.parents_permission).to be_truthy
      expect(student.classroom).to be_nil
      expect(student.type).to eq('Student')
    end
  end

  describe '#play_hooky' do
    it 'returns the play hooky message' do
      expect(student.play_hooky).to eq('¯\\(ツ)/¯')
    end
  end

  describe '#assign_classroom' do
    it 'adds the student to the classroom' do
      expect(classroom).to receive(:add_student).with(student)
      student.assign_classroom(classroom)
    end

    it 'does not add the student to the classroom if classroom is nil' do
      student.assign_classroom(nil)
      expect(student.classroom).to be_nil
    end
  end
end
