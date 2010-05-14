class PhonesController < ApplicationController
  before_filter :login_required, :find_user, :find_phone
  
  def new
    @phone = Phone.new
  end
  
  def create
    @phone = Phone.new(params[:phone])
    @phone.update_attributes(:user_id => @user.id)
    respond_to do |wants|
      if @phone.save
        flash[:notice] = 'Criação de Telefone realizada com sucesso!'
        wants.html { redirect_to(root_path) }
      else
        wants.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @phone = @user.phones.find_by_id(params[:id])
  end
  
  def find_phone
    @phone = Phone.find_by_id(params[:id]) if params[:id]
  end
end