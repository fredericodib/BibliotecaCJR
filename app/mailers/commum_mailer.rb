class CommumMailer < ApplicationMailer

	def render_book(user, book)
		@user = user
		@book = book
		mail(to: @user.email, subject: 'Livro ' + @book.name.to_s + ' alugado com sucesso!')
	end

	def late_book(user, book)
		@user = user
		@book = book
		mail(to: @user.email, subject: 'Tempo de posse do livro expirou!')
	end

	def almost_late_book(user, book)
		@user = user
		@book = book
		mail(to: @user.email, subject: 'Tempo de posse to livro está perto do fim!')
	end
end
