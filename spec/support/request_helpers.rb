# frozen_string_literal: true

module Requests
  module JsonHelpers
    def parsed_body
      JSON.parse(response.body)
    end

    def stub_authorization(user = create(:user))
      auth_result = double('auth_rommand_result')
      allow(auth_result).to receive(:result).and_return(user)
      allow(AuthorizeRequest).to receive(:call).and_return(auth_result)
    end
  end
end
