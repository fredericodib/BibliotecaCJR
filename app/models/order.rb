class Order < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: { rented: 0, late: 1, confirmation: 2, returned: 3 }

  before_create :init

  def init
  	self.status = :rented
  end

  def self.late_order
  	@orders = Order.where(status: :rented)
  	@orders.each do |order|
  		now = Time.now
  		if (now > order.created_at)
  			order.late!
  			@users = User.where(admin: true).all
  			@users.each do |admin|
  				AdminMailer.late_book_admin(order.user, order.book, admin).deliver_now
  			end
			CommumMailer.late_book(order.user, order.book).deliver_now
  		end
  	end
  end

  def self.monday_late_notification
    if Time.now.monday?
    	@orders = Order.where(status: :late)
    	@orders.each do |order|
    		@users = User.where(admin: true).all
    		@users.each do |admin|
    			AdminMailer.late_book_admin(order.user, order.book, admin).deliver_now
    		end
  		CommumMailer.late_book(order.user, order.book).deliver_now
    	end
    end
  end

  def self.almost_late_order
  	@orders = Order.where(status: :rented)
  	@orders.each do |order|
  		now = Time.now
  		if ((now < order.created_at + 21.day) && (now > order.created_at + 20.day))
			CommumMailer.almost_late_book(order.user, order.book).deliver_now
  		end
  	end
  end

  def self.monday_confirmation_notification
    if Time.now.monday?
    	@orders = Order.where(status: :confirmation)
    	@orders.each do |order|
    		@users = User.where(admin: true).all
    		@users.each do |admin|
    			AdminMailer.comfirm_book(order.user, order.book, admin).deliver_now
    		end
    	end
    end
  end

end
