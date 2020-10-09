# frozen_string_literal: true

RSpec.describe '[GET] /porjcts/:id' do
  let!(:current_user) { create(:user) }
  before { stub_authorization(current_user) }
  context 'when entity does not exist' do
    before { get api_project_path(SecureRandom.uuid) }

    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when project does not belong to current user' do
    let(:project) { create(:user).projects.create(attributes_for(:project)) }
    before { get api_project_path(project.id) }
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
  context 'when all params are valid' do
    let(:project) { current_user.projects.create(attributes_for(:project)) }
    before { get api_project_path(project.id) }
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end
    it 'returns requested entity' do
      expect(response).to match_json_schema('entities/project')
      expect(parsed_body['id']).to eq(project.id)
    end
  end
end
