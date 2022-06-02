require 'rails_helper'

RSpec.describe 'Subscription API', type: :request do
  describe 'POST /api/v1/subscriptions' do


    describe 'successful' do
      before(:each) do
        Tea.create!(title: "Matcha", description: "asofhasdf", temperature: 30, brew_time: "50")
        @req_body = {
                        "email": "hubertroberts@gmail.com",
                        "tea": "Matcha",
                        "frequency": 1
        }

        customer = {
                        "first_name": "Hubert",
                        "last_name": "Roberts",
                        "email": "hubertroberts@gmail.com",
                        "address": "399 S. Layoni"
        }

        post "/api/v1/customers", :params => customer
      end


      it 'has successful response' do
        post "/api/v1/subscriptions", :params => @req_body
        expect(response).to be_successful
        expect(response).to have_http_status(201)
      end

      it 'returns formatted json' do
        post '/api/v1/subscriptions', :params => @req_body
        expect(json[:data].keys).to eq([:id, :type, :attributes])
      end

      it 'has proper attribute keys' do
        post '/api/v1/subscriptions', :params => @req_body
        expect(json[:data][:attributes].keys).to eq([:title, :price, :status, :frequency])
      end
    end

    context 'unsuccessful' do
      describe 'no email' do
        #Customer.create!(first_name: "Hubert", last_name: "Roberts", email: "hubertroberts@gmail.com", address: "399 S. Layoni")
        before(:each) do
          Tea.create!(title: "Matcha", description: "asofhasdf", temperature: 30, brew_time: "50")
          @bad_body = {
                          "email": "",
                          "tea": "Matcha",
                          "frequency": 1
          }

          customer = {
                          "first_name": "Hubert",
                          "last_name": "Roberts",
                          "email": "hubertroberts@gmail.com",
                          "address": "399 S. Layoni"
          }

          post "/api/v1/customers", :params => customer
        end

        it 'has failed response' do
          post "/api/v1/subscriptions", :params => @bad_body

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for pre-existing' do
          post "/api/v1/subscriptions", :params => @bad_body

          expect(json[:error]).to eq({:message=>"No email provided."})
        end
      end

      describe 'no tea' do
        #Customer.create!(first_name: "Hubert", last_name: "Roberts", email: "hubertroberts@gmail.com", address: "399 S. Layoni")
        before(:each) do
          Tea.create!(title: "Matcha", description: "asofhasdf", temperature: 30, brew_time: "50")
          @bad_tea_body = {
                          "email": "hubertroberts@gmail.com",
                          "tea": "",
                          "frequency": 1
          }

          customer = {
                          "first_name": "Hubert",
                          "last_name": "Roberts",
                          "email": "hubertroberts@gmail.com",
                          "address": "399 S. Layoni"
          }

          post "/api/v1/customers", :params => customer
        end

        it 'has failed response' do
          post "/api/v1/subscriptions", :params => @bad_tea_body
          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for pre-existing' do
          post "/api/v1/subscriptions", :params => @bad_tea_body
          expect(json[:error]).to eq({:message=>"No tea provided."})
        end
      end

      describe 'no frequency' do
        #Customer.create!(first_name: "Hubert", last_name: "Roberts", email: "hubertroberts@gmail.com", address: "399 S. Layoni")
        before(:each) do
          Tea.create!(title: "Matcha", description: "asofhasdf", temperature: 30, brew_time: "50")
          @bad_frequency_body = {
                          "email": "hubertroberts@gmail.com",
                          "tea": "Matcha",
                          "frequency": ""
          }

          customer = {
                          "first_name": "Hubert",
                          "last_name": "Roberts",
                          "email": "hubertroberts@gmail.com",
                          "address": "399 S. Layoni"
          }

          post "/api/v1/customers", :params => customer
        end

        it 'has failed response' do
          post "/api/v1/subscriptions", :params => @bad_frequency_body

          expect(response).to_not be_successful
          expect(response).to have_http_status(400)
        end

        it 'gives proper response body for pre-existing' do
          post "/api/v1/subscriptions", :params => @bad_frequency_body

          expect(json[:error]).to eq({:message=>"No frequency provided."})
        end
      end
    end
  end
end
