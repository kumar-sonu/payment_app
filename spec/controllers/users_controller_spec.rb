require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController do
  before(:all) { @user = create(:user) }
  before(:each) { sign_in @user }

  describe 'GET #index' do
    context 'from login user' do
      before(:each) { get :index }
      it 'should be a success' do
        expect(response).to have_http_status(:success)
      end
      it { expect(response).to render_template('index') }
    end
  end

  describe 'GET #show' do
    it 'should be a success' do
      get :show, params: { id: @user.id }
      expect(response).to render_template('show')
    end
  end

  describe 'GET #new' do
    it do
      get :new
      expect(response).to render_template('new')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it do
      get :edit, params: { id: @user.id }
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it do
      post :create, params: {
        user: {
          name: Faker::Name.name,
          description: Faker::Lorem.sentence(word_count: 3),
          email: Faker::Internet.email,
          status: :active
        }
      }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH #update' do
    let(:old_name) { @user.name }
    let(:new_name) { 'Peter Parker' }
    it do
      patch :update, params: {
        id: @user.id,
        user: {
          name: new_name
        }
      }
      expect(@user.reload.name).to eq(new_name)
    end
  end

  describe 'DELETE #destroy' do
    it do
      delete :destroy, params: { id: @user.id }
      expect(response).to redirect_to('/users')
    end
  end
end
