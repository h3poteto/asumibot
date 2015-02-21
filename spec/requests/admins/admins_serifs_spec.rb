require 'rails_helper'

RSpec.describe "Admins::Serifs", type: :request do
  before(:each) do
    @admin = create(:admin)
    login @admin
    @params = { serif: attributes_for(:serif_new) }
    @serif = create(:serif_new)
  end

  describe "GET /admins/serifs" do
    it "works!" do
      get admins_serifs_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /admins/serifs/new" do
    it "works!" do
      get new_admins_serif_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /admins/serifs/edit" do
    it "works!" do
      get edit_admins_serif_path(@serif)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /admins/serifs/create" do
    it "works!" do
      post admins_serifs_path, @params
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT /admins/serifs/update" do
    it "works!" do
      put admins_serif_path(@serif), @params
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /admins/serifs/delete" do
    it "works!" do
      delete admins_serif_path(@serif)
      expect(response).to have_http_status(200)
    end
  end
end
