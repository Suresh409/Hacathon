def start_app(platformName,platformVersion,deviceName,app,serverUrl)

  	  $a1 = platformName
	  $a2= platformVersion
	  $a3 = deviceName
	  $a4 = app
	  $a5 = serverUrl
	  puts $a5
  def capabilities
      {
          "platformName" => "#{$a1}",
          "browserName" => "",
          "platformVersion" => "#{$a2}",
		  "deviceName" => "#{$a3}",
          "app" => "#{$a4}",
         
      }
    end
    
    http_client = ::Selenium::WebDriver::Remote::Http::Default.new
    http_client.timeout = 90
   
    
    Selenium::WebDriver.for(
        :remote,
        :desired_capabilities => capabilities,
        :url => "#{$a5}",
        :http_client => http_client
    )
end