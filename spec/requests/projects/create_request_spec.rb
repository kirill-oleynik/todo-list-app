# frozen_string_literal: true

RSpec.describe '[POST] /projects' do
  before(:each) { stub_authorization }

  let(:params) { { project: attributes_for(:project).slice(:title) } }
  before(:each) {  post api_projects_path, params: params }
  it 'returns 201 expected response with 201 status code' do
    expect(response).to have_http_status(201)
    expect(response).to match_json_schema('entities/project')
    expect(parsed_body[:title]).to eq(params[:title])
  end
end
