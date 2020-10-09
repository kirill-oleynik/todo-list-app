# frozen_string_literal: true

RSpec.describe '[PUT] /projects/:id' do
  let!(:current_user) { create(:user) }
  before { stub_authorization(current_user) }
  context 'when project does not exist' do
    before(:each) { put api_project_path(SecureRandom.uuid) }
    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when project do not belongs to current user' do
    let(:project) { create(:user).projects.create(attributes_for(:project)) }
    before(:each) { put api_project_path(project.id) }
    it 'returns  422 status code' do
      expect(response).to have_http_status(422)
    end
  end
  context 'wen attributes are valid' do
    let(:project) { current_user.projects.create(attributes_for(:project)) }
    let(:params) { { project: { title: 'new title' } } }
    before(:each) { put api_project_path(project.id), params: params }
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end
    it 'returns updated project' do
      expect(response).to match_json_schema('entities/project')
      expect(parsed_body['title']).to eq('new title')
    end
  end
end
