require 'rails_helper'

RSpec.describe 'Users API', type: :request do

    describe 'POST  /api/v1/users (user registration)' do
      before(:each) do

         @req_body = {
                          "first_name": "Hubert",
                          "last_name": "Roberts"
                          "email": "hubertroberts@test.com",
                          "address": "399 S. Layoni"
                        }

        end


      context 'successful' do
        it 'has successful response' do
          post "/api/v1/users", :params => @req_body

          expect(response).to be_successful
          expect(response).to have_http_status(201)
        end

        it 'returns formatted json' do
          post '/api/v1/users', :params => @req_body
          expect(json[:data].keys).to eq([:id, :type, :attributes])
        end

        it 'has proper attribute keys' do
          post '/api/v1/users', :params => @req_body
          expect(json[:data][:attributes].keys).to eq([:email, :api_key])
        end
      end

      context 'unsuccessful - email exists' do
        before(:each) do
          User.create!(first_name: "Hubert", last_name: "Roberts", email: "hubertroberts@gmail.com", address: "399 S. Layoni")
          @req_body = {
                           "first_name": "Hubert",
                           "last_name": "Roberts"
                           "email": "hubertroberts@test.com",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/users", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for password' do
          post "/api/v1/users", :params => @bad_req
          expect(json[:error]).to eq({:message=>"email already registered"})
        end
      end

      context 'unsuccesful - mismatched password/confirmation' do
        before(:each) do
          @req_body = {
                           "first_name": "Hubert",
                           "last_name": "Roberts"
                           "email": "hubertroberts@test.com",
                         }
        end

        it 'has failed response' do
          post "/api/v1/users", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for password' do
          post "/api/v1/users", :params => @bad_req
          expect(json[:error]).to eq({:message=>"absent address field"})
        end
      end

      context 'unsuccessful - first name not provided' do
        before(:each) do
          @req_body = {
                           "last_name": "Roberts"
                           "email": "hubertroberts@test.com",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/users", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for password' do
          post "/api/v1/users", :params => @bad_req
          expect(json[:error]).to eq({:message=>"First name not provided."})
        end
      end


      context 'unsuccessful - last name not provided' do
        before(:each) do
          @req_body = {
                           "first_name": "Hubert",
                           "email": "hubertroberts@test.com",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/users", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for missing password' do
          post "/api/v1/users", :params => @bad_req
          expect(json[:error]).to eq({:message=>"Last name not provided."})
        end
      end

      context 'unsuccessful - email not provided' do
        before(:each) do
          @req_body = {
                           "first_name": "Hubert",
                           "last_name": "Roberts"
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/users", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for missing confirmation' do
          post "/api/v1/users", :params => @bad_req
          expect(json[:error]).to eq({:message=>"Email not provided."})
        end
      end
  end
end
