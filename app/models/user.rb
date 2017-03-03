class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :orders, dependent: :destroy
  has_many :books, through: :orders

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true, :on => :create
	validates :password, presence: true, confirmation: true, length: { minimum: 6 }, :on => :create
	validates :password_confirmation, presence: true, length: { minimum: 6 }, :on => :create


  def can_rent_book?(book)
    if ((self.phone == "") || (self.name == "") || (self.phone == nil) || (self.name == nil))
      return "Atualize seus dados antes de alugar o livro!"
    end

    if book.active == false
      return "Esse livro já está alugado!"
    end

    rented = self.orders.find_by(status: :rented)
    late = self.orders.find_by(status: :late)
    confirmation = self.orders.find_by(status: :confirmation)
    if ((rented != nil) || (late != nil) || (confirmation != nil))
      return "Você já possui um livro alugado!"
    end

    order = self.orders.find_by(book_id: book.id)
    if (order != nil)
      today_date = Time.now
      if ((order.delivery_at + 10.days) > today_date)
        return "voce devolveu esse livro a menos de 10 dias, espere mais " + (((order.delivery_at + 10.days - today_date)/86400).to_i).to_s + " dias, para alugá-lo!"
      end
    end

    return true

  end
  	
end
