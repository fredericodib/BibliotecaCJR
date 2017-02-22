class AdminMailer < ApplicationMailer

	def render_book_admin(user, book, user_admin)
		@book = book
		@user = user
		@user_admin = user_admin
		mail(to: @user_admin.email, subject: 'Um novo livro foi alugado')
	end

	def late_book_admin(user, book, user_admin)
		@book = book
		@user = user
		@user_admin = user_admin
		mail(to: @user_admin.email, subject: 'O tempo de posse de um livro expirou!')
	end

	def comfirm_book(user, book, user_admin)
		@book = book
		@user = user
		@user_admin = user_admin
		mail(to: @user_admin.email, subject: 'Um novo livro foi marcado como devolvido, veja se está tudo em ordem!')
	end
end
