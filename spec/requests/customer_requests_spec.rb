require 'rails_helper'

RSpec.describe 'Customers API', type: :request do

    describe 'POST  /api/v1/customers (user registration)' do
      before(:each) do

         @req_body = {
                          "first_name": "Hubert",
                          "last_name": "Roberts",
                          "email": "hubertroberts@test.com",
                          "address": "399 S. Layoni"
                        }

        end

      context 'successful' do
        it 'has successful response' do
          post "/api/v1/customers", :params => @req_body

          expect(response).to be_successful
          expect(response).to have_http_status(201)
        end

        it 'returns formatted json' do
          post '/api/v1/customers', :params => @req_body
          expect(json[:data].keys).to eq([:id, :type, :attributes])
        end

        it 'has proper attribute keys' do
          post '/api/v1/customers', :params => @req_body
          expect(json[:data][:attributes].keys).to eq([:first_name, :last_name, :email, :address])
        end
      end


      context 'unsuccessful - email exists' do
        before(:each) do
          Customer.create!(first_name: "Hubert", last_name: "Roberts", email: "hubertroberts@gmail.com", address: "399 S. Layoni")
          @req_body = {
                           "first_name": "Hubert",
                           "last_name": "Roberts",
                           "email": "hubertroberts@test.com",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/customers", :params => @req_body
          post "/api/v1/customers", :params => @req_body

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for pre-existing' do
          post "/api/v1/customers", :params => @req_body
          post "/api/v1/customers", :params => @req_body

          expect(json[:error]).to eq({:message=>"Email already registered."})
        end
      end

      context 'unsuccesful - no address' do
        before(:each) do
          @bad_req = {
                           "first_name": "Hubert",
                           "last_name": "Roberts",
                           "email": "hubertroberts@test.com",
                         }
        end

        it 'has failed response' do
          post "/api/v1/customers", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for password' do
          post "/api/v1/customers", :params => @bad_req
          expect(json[:error]).to eq({:message=>"Address not provided."})
        end
      end

      context 'unsuccessful - first name not provided' do
        before(:each) do
          @bad_req = {
                           "last_name": "Roberts",
                           "email": "hubertroberts@test.com",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/customers", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for password' do
          post "/api/v1/customers", :params => @bad_req
          expect(json[:error]).to eq({:message=>"First name not provided."})
        end
      end


      context 'unsuccessful - last name not provided' do
        before(:each) do
          @bad_req = {
                           "first_name": "Hubert",
                           "email": "hubertroberts@test.com",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/customers", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for missing password' do
          post "/api/v1/customers", :params => @bad_req
          expect(json[:error]).to eq({:message=>"Last name not provided."})
        end
      end

      context 'unsuccessful - email not provided' do
        before(:each) do
          @bad_req = {
                           "first_name": "Hubert",
                           "last_name": "Roberts",
                           "address": "399 S. Layoni"
                         }
        end

        it 'has failed response' do
          post "/api/v1/customers", :params => @bad_req

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for missing confirmation' do
          post "/api/v1/customers", :params => @bad_req
          expect(json[:error]).to eq({:message=>"Email not provided."})
        end
      end
  end
end
