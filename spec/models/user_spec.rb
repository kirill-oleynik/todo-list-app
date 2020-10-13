# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'validations' do
    before { build(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { should have_many(:projects) }
    it { validate_uniqueness_of(:email).case_insensitive }
    it { should have_secure_password }
  end
  describe 'instance methods' do
    describe '#tasks' do
      let!(:user) { user_with_projects(2) }

      before do
        user.projects.map do |project|
          5.times { project.tasks.create(attributes_for(:task).slice(:title, :done)) }
        end
      end

      it 'returns all user tasks for all projects' do
        expect(user.tasks).to be_an_instance_of(Array)
        expect(user.tasks.length).to equal(10)
        expect(
          user.tasks.all? { |task| task.is_a?(Task) }
        ).to equal(true)
      end
    end
  end
end
