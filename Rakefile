#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Privly::Application.load_tasks

desc 'Run Jasmine tests with Webdriver'
task :webdriver do
	
	# Detect which tests we want to run
	case ENV['test']

	#### Testing privly-applications ####
	# Support added for Firefox and Chrome (all versions available)
	# On different platforms (Windows, Mac, Linux)
	when 'appsWeb'
		
		# Pages to be tested
		test_pages = [
			"http://dirp.grr.io:3000/apps/Help/new.html",
			"http://dirp.grr.io:3000/apps/Login/new.html",
			"http://dirp.grr.io:3000/apps/Index/new.html",
			"http://dirp.grr.io:3000/apps/PlainPost/new.html",
			# "http://dirp.grr.io:3000/apps/PlainPost/show.html",	
			"http://dirp.grr.io:3000/apps/ZeroBin/new.html",
			# "http://dirp.grr.io:3000/apps/ZeroBin/show.html"
		]

		# Specifying browser capabilities we need
		# Here Firefox
		caps = Selenium::WebDriver::Remote::Capabilities.firefox
		caps.version = "23"
		caps.platform = "Windows XP"

		# Instantiating the requested browser
		driver = Selenium::WebDriver.for(
			:remote,
			:url => "http://dreamrulez07:fb789f94-e013-4026-8cd9-27f0285e0147@ondemand.saucelabs.com:80/wd/hub",
			:desired_capabilities => caps)

		# Finally, we load the HTML pages with Webdriver
		test_pages.each do |x|
	  		driver.navigate.to x
	  		# Allow it to load
	  		# status = driver.execute_script('runTests();')
	  		status = driver.execute_script('return jasmine.ConsoleReporter.status;')
	  		output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  		print output
	  		# Make sure to exit with code > 0 if there is a test failure
	  		raise RuntimeError, 'Failure' unless status === 'success'
		end
		# Closing browser
		driver.quit


		# Specifying Browser capabilities we need
		# Here Chrome
		caps = Selenium::WebDriver::Remote::Capabilities.chrome
		caps.platform = 'Windows 8.1'
		caps.version = '33'

		# Instantiating the requested browser
		driver = Selenium::WebDriver.for(
			:remote,
			:url => "http://dreamrulez07:fb789f94-e013-4026-8cd9-27f0285e0147@ondemand.saucelabs.com:80/wd/hub",
			:desired_capabilities => caps)

		test_pages.each do |x|
	  		driver.navigate.to x
	  		# Allow it to load
	  		# status = driver.execute_script('runTests();')
	  		status = driver.execute_script('return jasmine.ConsoleReporter.status;')
	  		output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  		print output
	  		# Make sure to exit with code > 0 if there is a test failure
	  		raise RuntimeError, 'Failure' unless status === 'success'
		end
		# Closing browser
		driver.quit
	
	#### Testing privly-applications in Extension context ####
	# Support added for Firefox and Chrome (all versions available)
	# On different platforms (Windows, Mac, Linux)
	when 'appsExten'
		profile = Selenium::WebDriver::Firefox::Profile.new
		profile.add_extension("./privly-firefox.xpi")
		caps = Selenium::WebDriver::Remote::Capabilities.firefox
		caps.version = "23"
		caps.platform = "Windows XP"
		caps.firefox_profile = profile

		driver = Selenium::WebDriver.for(
			:remote,
			:url => "http://dreamrulez07:fb789f94-e013-4026-8cd9-27f0285e0147@ondemand.saucelabs.com:80/wd/hub",
			:desired_capabilities => caps)

		
		sleep 7
#		driver.manage.timeouts.implicit_wait = 300
		driver.manage.timeouts.script_timeout = 30
		driver.manage.timeouts.page_load = 10

		test_pages = [
			"chrome://privly/content/privly-applications/Help/new.html",
			"chrome://privly/content/privly-applications/Login/new.html",
			"chrome://privly/content/privly-applications/Index/new.html",
			"chrome://privly/content/privly-applications/PlainPost/new.html",
			# "chrome://privly/content/privly-applications/PlainPost/show.html",
			"chrome://privly/content/privly-applications/ZeroBin/new.html",
			# "chrome://privly/content/privly-applications/ZeroBin/show.html"
		]

		# Finally, we load the HTML pages with Webdriver
		test_pages.each do |x|
	  		driver.navigate.to x
	  		# Allow it to load	  
	  		# status = driver.execute_script('runTests();')
	  		status = driver.execute_script('return jasmine.ConsoleReporter.status;')
	  		output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  		print output
	  		# Make sure to exit with code > 0 if there is a test failure
	  		raise RuntimeError, 'Failure' unless status === 'success'
		end
		driver.quit
	



	# For testing privly-applications locally
	when 'localappsWeb'

		# Pages to be tested
		test_pages = [
			"http://localhost:3000/apps/Help/new.html",
			"http://localhost:3000/apps/Login/new.html",
			"http://localhost:3000/apps/Index/new.html",
			"http://localhost:3000/apps/PlainPost/new.html",
			# "http://localhost:3000/apps/PlainPost/show.html",	
			"http://localhost:3000/apps/ZeroBin/new.html",
			# "http://localhost:3000/apps/ZeroBin/show.html"
		]

#		profile = Selenium::WebDriver::Firefox::Profile.new
		driver = Selenium::WebDriver.for :firefox

		# Finally, we load the HTML pages with Webdriver
		test_pages.each do |x|
	  		driver.navigate.to x
	  		# Allow it to load
	  		# status = driver.execute_script('runTests();')
	  		status = driver.execute_script('return jasmine.ConsoleReporter.status;')
	  		output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  		print output
	  		# Make sure to exit with code > 0 if there is a test failure
	  		raise RuntimeError, 'Failure' unless status === 'success'
		end
		# Closing browser
		driver.quit

		driver = Selenium::WebDriver.for :chrome

		# Finally, we load the HTML pages with Webdriver
		test_pages.each do |x|
	  		driver.navigate.to x
	  		# Allow it to load
	  		# status = driver.execute_script('runTests();')
	  		status = driver.execute_script('return jasmine.ConsoleReporter.status;')
	  		output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  		print output
	  		# Make sure to exit with code > 0 if there is a test failure
	  		raise RuntimeError, 'Failure' unless status === 'success'
		end
		# Closing browser
		driver.quit

	when 'localappsExten'

		### If you need to specify Proxy ###
		# PROXY = "proxy.iiit.ac.in:8080"
		profile = Selenium::WebDriver::Firefox::Profile.new
		profile.add_extension("./privly-firefox.xpi")
		# profile.proxy = Selenium::WebDriver::Proxy.new(
			# :http	=> PROXY,
			# :ftp	=> PROXY,
			# :ssl	=> PROXY
		# )
		driver = Selenium::WebDriver.for :firefox, :profile => profile
		
		sleep 7
#		driver.manage.timeouts.implicit_wait = 300
		driver.manage.timeouts.script_timeout = 30
		driver.manage.timeouts.page_load = 10

		test_pages = [
			"chrome://privly/content/privly-applications/Help/new.html",
			"chrome://privly/content/privly-applications/Login/new.html",
			"chrome://privly/content/privly-applications/Index/new.html",
			"chrome://privly/content/privly-applications/PlainPost/new.html",
			# "chrome://privly/content/privly-applications/PlainPost/show.html",
			"chrome://privly/content/privly-applications/ZeroBin/new.html",
			# "chrome://privly/content/privly-applications/ZeroBin/show.html"
		]

		# Finally, we load the HTML pages with Webdriver
		test_pages.each do |x|
	  		driver.navigate.to x
	  		# Allow it to load	  
	  		# status = driver.execute_script('runTests();')
	  		status = driver.execute_script('return jasmine.ConsoleReporter.status;')
	  		output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  		print output
	  		# Make sure to exit with code > 0 if there is a test failure
	  		raise RuntimeError, 'Failure' unless status === 'success'
		end
		driver.quit


		# profile = Selenium::WebDriver::Chrome::Profile.new
		# profile.add_extension("./privly-chrome.crx")
		# driver = Selenium::WebDriver.for :chrome, :profile => profile

	else
		raise ArgumentError, 'Unknown tests requested'
	end
end