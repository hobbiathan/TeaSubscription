class Api::V1::CustomersController < ApplicationController
  def create
    if params["email"].blank?
      error("Email not provided.")
    elsif params["first_name"].blank?
      error("First name not provided.")
    elsif params["last_name"].blank?
      error("Last name not provided.")
    elsif params["address"].blank?
      error("Address not provided.")
    else
      existing = Customer.find_by_email(params[:email])
      if !!(existing)
        error("Email already registered.")
      else
        user = Customer.create(customer_params)
        json_response(CustomerSerializer.new(user), :created)
      end
    end
  end


  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end
