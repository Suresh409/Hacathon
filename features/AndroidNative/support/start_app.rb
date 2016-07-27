def start_app(platformName,platformVersion,deviceName,app,apppackage,appactivity)
  	  $a1 = platformName
	  $a2= platformVersion
	  $a3 = deviceName
	  $a4 = app
	  $a5 = apppackage
	  $a6 = appactivity
	  
  def capabilities
  puts $a1
      {
          "platformName" => "#{$a1}",
          "browserName" => "",
          "platformVersion" => "#{$a2}",
		  "deviceName" => "#{$a3}",
          "app" => "#{$a4}",
          "app-package" => "#{$a5}",
          "app-activity" => "#{$a6}"
      }
    end
    
    http_client = ::Selenium::WebDriver::Remote::Http::Default.new
    http_client.timeout = 90
   
    
    Selenium::WebDriver.for(
        :remote,
        :desired_capabilities => capabilities,
        :url => 'http://127.0.0.1:4723/wd/hub',
        :http_client => http_client
    )
end
