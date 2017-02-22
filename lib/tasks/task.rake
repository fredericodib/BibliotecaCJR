namespace :tasks do

	task :late_order => :environment do
		puts "ok"
	   Order.late_order
	end

	task :monday_late_notification => :environment do
		puts "ok"
	   Order.monday_late_notification
	end

	task :almost_late_order => :environment do
	puts "ok"
	   Order.almost_late_order
	end

	task :monday_confirmation_notification => :environment do
		puts "ok"
	   Order.monday_confirmation_notification
	end
end

task :tasks => 'tasks:all'