
class SubscriptionsController < ApplicationController
  protect_from_forgery with: :null_session # For APIs, we disable CSRF protection
  before_action :require_authentication

  def create
    @plans = ["no membership", "$3 membership", "$5 membership" , "$10 membership"]
    plan = membership_params
    subscription = Subscription.new(plan)
    subscription.expiry = Date.today + 1.month
    subscription.user = @current_user
    if subscription.save
      render json: {membership: subscription, msg:@plans[plan[:membership]]}
    else
      render json: subscription.errors.full_messages
    end
  end

  private
  def membership_params
    params.require(:subscription).permit(:membership)
  end

  def require_authentication
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    begin
      decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256')
      render json: {error: "invalid token"} if !decoded_token[0]['user_id']
      @current_user = User.find(decoded_token[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: header }, status: :unauthorized
    end
  end
end