class SessionsController < ApplicationController
    def create
    user=User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
        #render 'new'
    else
        flash.now[:error]="Invalid email/password combination"
        render 'new'
    end
   end
   def show
   
   end
    
end
