class ContactController < ApplicationController
  def contact_information
    render "contact"
  end

  def show_contact
    @first_name = params[:first]
    @last_name = params[:last]
    render "contact_submitted"
  end
end