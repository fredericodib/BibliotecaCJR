class CommumMailer < ApplicationMailer

	def render_book(user, book)
		@user = user
		@book = book
		mail(to: @user.email, subject: 'Livro alugado')
	end

	def late_book(user, book)
		@user = user
		@book = book
		mail(to: @user.email, subject: 'Livro atrasado')
	end

	def almost_late_book(user, book)
		@user = user
		@book = book
		mail(to: @user.email, subject: 'Livro alugado')
	end
end
