class Api::V1::UsersController < ApplicationController
  def login
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(
        JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
  end
  
  # {
  #   "csrf": "49u8X0WUMkVFQ2oWuU0Lv3fpSaHdAU8CQBnrwb4UTUhoopyccg0dVBuChGAJ0XT/olzKFTW4r9LJwZ0fFgZPXQ=="
  #  }

  def signup
    user = User.new(user_params)
    if user.save
      payload  = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
  
      response.set_cookie(
        JWTSessions.access_cookie,
        value: tokens[:access],
        httponly: true,
        secure: Rails.env.production?)
      render json: { csrf: tokens[:csrf] }
    else
      render json: { error: user.errors.full_messages.join(' ') }, status: :unprocessable_entity
    end
  end

  def signout
    puts "-------------------------"
    puts payload
    puts "-------------------------"
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: "Cannot find email/password combination" }, status: :not_found
  end

  def user_params
    params.permit(:name, :surname, :email, :password)
  end
end
