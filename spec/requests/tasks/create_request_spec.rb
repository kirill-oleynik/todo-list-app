# frozen_string_literal: true

RSpec.describe '[POST] /tasks' do
  before { stub_authorization(user) }
  context 'with valid project_id requested' do
    context 'and all task attributes given' do
      let(:project) { create(:project) }
      let(:user) { project.user }
      let(:params) do
        {
          task: {
            project_id: project.id,
            title: 'task_title',
            done: 'done'
          }
        }
      end
      before { post api_tasks_path, params: params }
      it 'returns 201 status code' do
        expect(response).to have_http_status(201)
      end
      it 'returns created task' do
        expect(response).to match match_json_schema('entities/task')
        expect(parsed_body['title']).to eq('task_title')
        expect(parsed_body['done']).to eq(true)
        expect(parsed_body['project_id']).to eq(project.id)
        expect(parsed_body['user_id']).to eq(user.id)
      end
    end
  end
  context 'when invalid project_id given' do
    let(:project) { create(:project) }
    let(:user) { project.user }
    before { post api_tasks_path, params: { task: { project_id: SecureRandom.uuid } } }
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
    it 'returns expected error' do
      expect(parsed_body).to eq({ 'project' => 'Not found' })
    end
  end
end
