class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  # before_action :initializeDefaultProducts
  
  private
  # def initializeDefaultProducts
  #   Product.find_or_create_by(title: "Harry Potter's Wand", summary: 'This is the magic wand of Harry', description: 'The magic wand of a hero', initial_value: '50.0', final_value: '35.99')
  #   Product.find_or_create_by(title: "Voldemort's Wand", summary: 'This is the magic wand of Evil lord', description: 'This is the magic wand of the man whose the name should not be spoken', initial_value: '32.0', final_value: '30')
  #   Product.find_or_create_by(title: "Anakin's lighsaber", summary: 'This is the lightsaber of the chosen one', description: 'An item that should not be missing from any collection', initial_value: '12.0', final_value: '120.99')
  #   Product.find_or_create_by(title: "Darth Sidius lighsaber", summary: 'The saber of the vicius Sith lord', description: 'Lorem Ipum dollor evil color', initial_value: '230', final_value: '90.4')
  #   Product.find_or_create_by(title: "Captain's America shield", summary: 'The shield of the leader of the avengers', description: 'This shield is unbreakable! Throw it to anyones head and it will not break', initial_value: '155', final_value: '89.1')
  #   Product.find_or_create_by(title: "Thor's hammer", summary: 'It is build from real steel from Asgard', description: 'This is a very big description full of info', initial_value: '12', final_value: '213')
  #   User.find_or_create_by(name: "Anakin", surname: 'Skywalker', email: 'anakin@starwars.com', password: 'thechosenone')
  # end

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end
  
  def not_authorized
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

end
