require 'rails_helper'

RSpec.describe "Trailers", type: :request do
  describe "GET /trailers" do
    it "works! (now write some real specs)" do
      get trailers_path
      expect(response).to have_http_status(200)
    end
  end
end
