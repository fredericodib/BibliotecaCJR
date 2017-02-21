class AdminMailer < ApplicationMailer

	def render_book_admin(user, book, user_admin)
		@book = book
		@user = user
		@user_admin = user_admin
		mail(to: @user_admin.email, subject: 'Livro alugado')
	end

	def late_book_admin(user, book, user_admin)
		@book = book
		@user = user
		@user_admin = user_admin
		mail(to: @user_admin.email, subject: 'Livro atrasado')
	end

	def comfirm_book(user, book, user_admin)
		@book = book
		@user = user
		@user_admin = user_admin
		mail(to: @user_admin.email, subject: 'Livro pendente')
	end
end
