require 'rails_helper'

RSpec.describe "Admins::Serifs", type: :request do
  include Rack::Test::Methods

  before(:each) do
    @admin = create(:admin)
    login @admin
    @params = { serif: attributes_for(:serif_new) }
    @serif = create(:serif_new)
  end

  describe "GET /admins/serifs" do
    it "works!" do
      get admins_serifs_path
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET /admins/serifs/new" do
    it "works!" do
      get new_admins_serif_path
      expect(last_response.status).to eq(200)
    end
  end

  describe "GET /admins/serifs/edit" do
    it "works!" do
      get edit_admins_serif_path(@serif)
      expect(last_response.status).to eq(200)
    end
  end

  describe "POST /admins/serifs/create" do
    it "works!" do
      post admins_serifs_path, @params
      expect(last_response.status).to eq(302)
      expect(last_response.errors).to eq("")
    end
  end

  describe "PUT /admins/serifs/update" do
    it "works!" do
      put admins_serif_path(@serif), @params
      expect(last_response.status).to eq(302)
      expect(last_response.errors).to eq("")
    end
  end

  describe "DELETE /admins/serifs/delete" do
    it "works!" do
      delete admins_serif_path(@serif)
      expect(last_response.status).to eq(302)
      expect(last_response.errors).to eq("")
    end
  end
end
