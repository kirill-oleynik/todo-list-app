# frozen_string_literal: true

RSpec.describe '[GET] /projects' do
  let(:params) { { projects: { filters: { title: title_filter } } } }
  context 'when user has no projects' do
    let(:user) { user_with_projects(0) }
    let(:title_filter) { nil }
    before { stub_authorization(user) }
    before(:each) { get api_projects_path, params: params }

    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns empy collection of projects' do
      expect(parsed_body).to have_key('projects')
      expect(parsed_body['projects']).to eq([])
      expect(response).to match_json_schema('entities/projects')
    end
  end
  context 'when user has projects & title filter not provided' do
    let(:user) { user_with_projects(7) }
    before { stub_authorization(user) }
    let(:title_filter) { nil }
    before(:each) { get api_projects_path, params: params }

    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end
    it 'returns all projects' do
      expect(parsed_body).to have_key('projects')
      expect(parsed_body['projects'].length).to eq(7)
      expect(response).to match_json_schema('entities/projects')
    end
  end
  context 'when user has projects & title filter provided' do
    let(:user) { user_with_projects(5) }
    let(:title_filter) { 'tle-' }
    before do
      5.times { |value| user.projects.create(attributes_for(:project, title: "title-#{value}")) }
      stub_authorization(user)
      get api_projects_path, params: params
    end
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns all matching entities' do
      expect(parsed_body).to have_key('projects')
      expect(parsed_body['projects'].length).to equal(5)
      expect(response).to match_json_schema('entities/projects')
    end
  end
end
