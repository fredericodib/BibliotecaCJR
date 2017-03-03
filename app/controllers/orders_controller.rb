class OrdersController < ApplicationController

	def rent_book
		@user = current_user
		@book = Book.find(params[:id])

		condition = @user.can_rent_book?(@book)
		if condition == true
			@user.books << @book
			@book.update_attributes(active: false)

			@users = User.where(admin: true).all
  			@users.each do |admin|
				AdminMailer.render_book_admin(@user, @book, admin).deliver_now
			end
			CommumMailer.render_book(@user, @book).deliver_now
			redirect_to root_path, notice: 'Livro alugado com sucesso!'
		elsif condition == "Atualize seus dados antes de alugar o livro!"
			redirect_to user_settings_path, alert: condition
		else
			redirect_to root_path, alert: condition
		end
	end

	def return_book
		@order = Order.find(params[:id])
		if @order.confirmation?
			redirect_to user_settings_path, alert: 'Você já marcou esse livro como devolvido, aguarde a validação!'
		else
			@order.confirmation!

			@users = User.where(admin: true).all
	  		@users.each do |admin|
	  			AdminMailer.comfirm_book(@order.user, @order.book, admin).deliver_now
	  		end
	  		redirect_to root_path, notice: 'Livro devolvido, espere a validação do administrador!'
	  	end
	end

	def confirm_return
		@order = Order.find(params[:id])
		@order.returned!
		@order.book.update_attributes(active: true)
		time = Time.now
		@order.update_attributes(delivery_at: time)
		redirect_to root_path, notice: 'Livro devolvido com sucesso!'
	end
end
