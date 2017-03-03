class UsersController < ApplicationController
	before_filter :authenticate_user!
  	before_filter :is_administratior?, only: [:new, :create, :admin_control]

	def new
	    @user = User.new
	end

	def create
	  	user = User.new(user_params)

	    if user.save
	      	redirect_to root_path, notice: 'Conta criada com sucesso!'
	    else
	      	redirect_to sign_up_path, alert: 'Erro ao criar conta!'
	    end
	end

	def update
		@user = current_user
	    if @user.update(user_params)
	      	redirect_to user_settings_path, notice: 'Conta atualizada com sucesso!'
	    else
	      	redirect_to user_settings_path, alert: 'Erro ao atualizar conta!'
	    end
	end

	def destroy
		@user = User.find(params[:id])
	    @user.destroy
	    respond_to do |format|
	      format.html { redirect_to admin_control_url, notice: 'Usuário apagado com sucesso!' }
	      format.json { head :no_content }
	    end
	end

	def chenge_admin
		@user = User.find(params[:id])
		if @user.admin
			@user.update_attributes(admin: false)
		else
			@user.update_attributes(admin: true)
		end
		redirect_to admin_control_url
	end

	def user_dates
		@user = current_user
		@order = @user.orders.last
		@orders = @user.orders.where(status: :returned).all.order(created_at: :asc)
	end

	def admin_control
		@user = current_user
		@all_users = User.all.order(email: :asc)
		@orders_returned = Order.where(status: :returned).all.order(created_at: :asc)
		@orders_confirmation = Order.where(status: :confirmation).all.order(created_at: :asc)
		@orders_rented = Order.where(status: :rented).all.order(created_at: :asc)
		@orders_late = Order.where(status: :late).all.order(created_at: :asc)
	end

	private

	def user_params  
	    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :admin)
	end
end
