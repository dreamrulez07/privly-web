#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Privly::Application.load_tasks

desc 'Run Jasmine tests with Webdriver'
task :webdriver do
	
	# Detect which browser we want to run
	case ENV['browser']

	# For testing firefox extension locally
	when 'fexten'
#		profile = Selenium::WebDriver::Firefox::Profile.new

		PROXY = "proxy.iiit.ac.in:8080"
		profile = Selenium::WebDriver::Firefox::Profile.new
		profile.add_extension("./privly-firefox.xpi")
		profile.proxy = Selenium::WebDriver::Proxy.new(
			:http	=> PROXY,
			:ftp	=> PROXY,
			:ssl	=> PROXY
		)
		driver = Selenium::WebDriver.for :firefox, :profile => profile
	
	when 'chrome'
		profile = Selenium::WebDriver::Chrome::Profile.new
		profile.add_extension("./privly-chrome.crx")

		driver = Selenium::WebDriver.for :chrome, :profile => profile
		#TODO: detect chromium path? I use Linux, this is the path on my machine
		#Selenium::WebDriver::Chrome.path = '/usr/bin/google-chrome'
		#driver = Selenium::WebDriver.for :chrome
#		driver = Selenium::WebDriver.for(
#			:remote,
#			:desired_capabilities => :chrome)
	
	# Firefox extension integrated to SauceLabs
	when 'firefox'
		profile = Selenium::WebDriver::Firefox::Profile.new
		profile.add_extension("./privly-firefox.xpi")
		caps = Selenium::WebDriver::Remote::Capabilities.firefox
		caps.version = "23"
		caps.platform = "Windows XP"
		caps.firefox_profile = profile
		# caps.version = "5"
		# caps.platform = :LINUX
#		driver = Selenium::WebDriver.for :firefox
		driver = Selenium::WebDriver.for(
			:remote,
			:url => "http://dreamrulez07:fb789f94-e013-4026-8cd9-27f0285e0147@ondemand.saucelabs.com:80/wd/hub",
			:desired_capabilities => caps)
	else
		raise ArgumentError, 'Unknown browser requested'
	end
	
	sleep 7
#	driver.manage.timeouts.implicit_wait = 300
	driver.manage.timeouts.script_timeout = 300
	driver.manage.timeouts.page_load = 10

	test_pages = [#"http://dirp.grr.io:3000/apps/Help/new.html"
	"chrome://privly/content/privly-applications/Help/new.html"
#	"http://localhost:3000/apps/Help/new.html"
#	"http://dirp.grr.io:3000/apps/Login/new.html",
#	"http://dirp.grr.io:3000/apps/Index/new.html",
#	"http://dirp.grr.io:3000/apps/PlainPost/new.html",
#	"http://dirp.grr.io:3000/apps/PlainPost/show.html",
#	"http://dirp.grr.io:3000/apps/ZeroBin/new.html",
#	"http://dirp.grr.io:3000/apps/ZeroBin/show.html"
	]

	# Finally, we load the HTML pages with Webdriver
	test_pages.each do |x|
	  driver.navigate.to x
	  # Allow it to load
	  
#	  driver.execute_script("runTests();")
#	  sleep 3
	  status = driver.execute_script('runTests();')
#	  status = driver.execute_script('return jasmine.ConsoleReporter.status;')
#	  output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  print status
	  # Make sure to exit with code > 0 if there is a test failure
	  #raise RuntimeError, 'Failure' unless status === 'success'
	end
#	driver.quit
end
