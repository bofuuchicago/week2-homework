Rails.application.routes.draw do

  get "/greet" => "greet#show_greet"
  get "/contact" => "contact#contact_information"
  get "/contact_show" => "contact#show_contact"
  get "/weather" => "weather#enter_city"
  get "/current_conditions" => "weather#show_current_conditions"

end
