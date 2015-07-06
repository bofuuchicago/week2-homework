class GreetController < ApplicationController
  def show_greet
    @salutation = params[:salutation]
    if(@salutation == nil)
      @salutation = 'hello'
    end
    render "greet"
  end
end