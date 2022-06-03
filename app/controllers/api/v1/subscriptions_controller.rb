class Api::V1::SubscriptionsController < ApplicationController
  before_action :get_info, only: [:create, :update]

  def index
    @customer = Customer.find_by_email(params[:email])
    if !(@customer)
      error("Customer does not exist. Please register using our Customer endpoint.")
    else
      json_response(SubscriptionSerializer.new(@customer.subscriptions), :created)
    end
  end

  def create
    if params[:email].present?
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
          end
        end
      end
    end
  end

  def update
    if params[:subscription_id].blank?
      error("No subscription ID provided.")
    elsif params[:status].blank?
      error("No status code provided.")
    else
      @sub = Subscription.find(params[:subscription_id])

      if @sub.status == "active" && params[:status] == 0
        error("Subscription is already active.")
      elsif @sub.status == "inactive" && params[:status] == 1
        error("Subscription is already inactive.")
      else
        @sub.update(status: params[:status])

        if @sub.save
          json_response(SubscriptionSerializer.new(@sub), :created)
        end
      end
    end
  end

  private
  def get_info
    @customer = Customer.find_by_email(params[:email])
    @tea = Tea.find_by_title(params[:tea])
  end
end
