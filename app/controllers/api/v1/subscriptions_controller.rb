class Api::V1::SubscriptionsController < ApplicationController
  before_action :get_info, only: [:create, :update]

  def index

  end

  def create
    if params[:email].blank?
      error("No email provided.")
    elsif params[:tea].blank?
      error("No tea provided.")
    elsif params[:frequency].blank?
      error("No frequency provided.")
    else
      if !(@customer)
        error("Customer does not exist. Please register using our Customer endpoint.")
      elsif !(@tea)
        error("Tea does not exist.")
      else
        sub = @customer.subscriptions.create(title: "#{@customer.first_name}'s subscription", price: 5, frequency: params[:frequency].to_i, customer_id: @customer.id)
        tea_sub = TeaSub.create(tea_id: @tea.id, subscription_id: sub.id)
        if sub.save
          json_response(SubscriptionSerializer.new(sub), :created)
        else
          render json_response
        end
      end

    end
  end

  def update

  end

  private
  def get_info
    @customer = Customer.find_by_email(params[:email])
    @tea = Tea.find_by_title(params[:tea])
  end
end
