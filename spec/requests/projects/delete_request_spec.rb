# frozen_string_literal: true

RSpec.describe '[DELETE] /projects/:id' do
  let!(:current_user) { create(:user) }
  before(:each) { stub_authorization(current_user) }
  context 'when arguments are valid' do
    let(:project) { current_user.projects.create(attributes_for(:project)) }
    before(:each) { delete api_project_path(project.id) }
    it 'deletes requested project' do
      expect(Project.exists?(project.id)).to equal(false)
    end
    it 'returns 204 status code' do
      expect(response).to have_http_status(204)
    end
  end
  context 'when project does not exist' do
    before(:each) { delete api_project_path(SecureRandom.uuid) }
    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when project does not belong to curren user' do
    let(:project) { create(:user).projects.create(attributes_for(:project)) }
    before(:each) { delete api_project_path(project.id) }
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
end
