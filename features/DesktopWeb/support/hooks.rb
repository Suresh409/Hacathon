$i = 0
$j=0;
$logFile = $logfileFolderPath + "#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}" + ".txt"
$logger= Logger.new($logFile, 0, 100 * 1024 * 1024)
$logger.datetime_format = "%Y-%m-%d %H:%M:%S"

Before do |scenario|

  @Excel = Excel.new()
    $deviceID =  ENV['DEVICE_ID']
	$deviceType = ENV['DEVICE_TYPE']
    $s = scenario.name
    $completeScenario = scenario.name
  if $s.include? ","
    @x = $s.split(",")
    $s = @x[0]
  end
  
  #Create New PDF file
  $pdf = Prawn::Document.new
  $pdf.text "Scenario:" + $s
  $j=0
  @count = 0       
    @tests = Array.new
    scenario.test_steps.each{|r|
    if( r.name != "AfterStep hook")
              @tests << r
    end
              }
 
  $current_feature =  if scenario.respond_to?('scenario_outline')
              # execute the following code only for scenarios outline (starting from the second example)
              scenario.scenario_outline.feature
            else
              # execute the following code only for a scenario and a scenario outline (the first example only)
              scenario.feature
            end
 
  $time = Time.now 
  $hr_Start = $time.hour
  $min_Start = $time.min
  $sec_Start = $time.sec
  $startTime = "#{$hr_Start}" + ":" + "#{$min_Start}" + ":" + "#{$sec_Start}"
  
  @Excel.WriteTime($startTime, 5, $current_feature,$deviceBasedExcelPath)
  #Log generation
  if $generatelog == true
  $logger.info("#{$current_feature} : #{$s} : Started")
  end
  
  case ENV['BROWSER']
    when 'ff', 'Firefox'
          caps = Selenium::WebDriver::Remote::Capabilities.firefox
          caps[:name] = "Watir WebDriver"
    
          $driver = Watir::Browser.new(
          :remote,
          :url => "http://localhost:4444/wd/hub",
          :desired_capabilities => caps)
          $driver.window.maximize
          browser_name = 'Firefox'
      
    when 'chrome'
            caps = Selenium::WebDriver::Remote::Capabilities.chrome
            caps[:name] = "Watir WebDriver"
        
            $driver = Watir::Browser.new(
            :remote,
            :url => "http://localhost:4444/wd/hub",
            :desired_capabilities => caps)
            $driver.window.maximize
            browser_name = 'Chrome'
    
    #$b = Watir::Browser.new :chrome, :prefs => prefs_hash
        
    when 'ie'
            caps = Selenium::WebDriver::Remote::Capabilities.ie
            caps[:name] = "Watir WebDriver"
            
            $driver = Watir::Browser.new(
            :remote,
            :url => "http://localhost:4444/wd/hub",
            :desired_capabilities => caps)
            $driver.window.maximize
            browser_name = 'IE'
         
      environment = 'dev'
      url = 'http://watirwebdriver.com/' 
      domain = "http://watirwebdriver.com/"
      
    if ENV['CLIENT'].nil?
      client = 'user/password'
    else
      client = ENV['CLIENT']
    end
    
    test_env = {   :browser => $driver,
                   :browser_name => browser_name,
                   :url => url,
                   :env => environment,
                   :client => client,
                   :login => nil,
                   :domain => domain }

  
  end

  end
  
After do |scenario|

@Excel = Excel.new()
  #Create Time Stamp for Report/ScreenShot etc...
  time1 = Time.now
  @hr_End = time1.hour
  @min_End = time1.min
  @sec_End = time1.sec
  @endTime = "#{@hr_End}" + ":" + "#{@min_End}" + ":" + "#{@sec_End}"
  @timeStamp = @hr_End.to_s + @min_End.to_s + @sec_End.to_s
  @Excel.WriteTime(@endTime,6,$current_feature,$deviceBasedExcelPath)
  $pdfPath = "#{$currentdir}" + "/Results/" + $current_feature.to_s + "_" + $deviceID.to_s + "_" + $s.to_s + "_" + "#{@timeStamp.to_s}" +".pdf"
  @diffTime = Time.diff(Time.parse($startTime), Time.parse(@endTime), '%h:%m:%s')
  @timeArr = @diffTime.to_s.split(":diff")
  @timediff = @timeArr[1]
  @x1= @timediff.to_s.gsub("=>","")
  @x2 = @x1.to_s.gsub("}","")
  totlaExecutionTime = @x2.to_s.gsub('"',"")
  @Excel.WriteTime(totlaExecutionTime,7,$current_feature,$deviceBasedExcelPath)

if scenario.failed?
 #Get the Failure message 
  failureMsg = "#{scenario.exception.message}"
  #Read Step name
  @stepname=  @tests[@count].name
  $stepname = @stepname
    @count += 1;
  #Generate time stamp
	@var = $s.to_s + "_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}" + ".png"
	puts @var
    $driver.screenshot.save @var
    embed @var, 'image/png'
   
  #Write Status to Excel
  #about args: 1-status,1- Feature/module name, 3- pdfPath to add hyper link in excel,4-hyper link name,5-Result excel path
  @Excel.Write("Fail",$current_feature,$pdfPath,"Result",$deviceBasedExcelPath)
    #Log generation
    if $generatelog == true
      $logger.error("#{$s} Failed.")
      $logger.error("Failure Reason: #{failureMsg}")
    end
    if $j>0
      $pdf.start_new_page
    end
  #Add image,step name and step status to pdf
    @avatar = $folder + @var + "_" + $i.to_s + ".png"
  $pdf.text "Step:" + $stepname 
  $pdf.text "Status:<color rgb='ff0000'>Fail</color>", :inline_format => true
  $pdf.text "Reason:<color rgb='ff0000'>#{failureMsg}</color>", :inline_format => true
  $pdf.move_down 10
  if File.exist?(@avatar) == true
    $pdf.image @avatar, :position => :center,:vposition => :center, :scale => 0.3
  else
    if $generatelog == true
    $logger.error("Expected screen shot not found in the current directory, so PDF Not generated")
    end
  end
  $i = $i+1
  $j = $j + 1
else
    @Excel.Write("Pass",$current_feature,$pdfPath,"Result",$deviceBasedExcelPath)
end
  #Save PDF in the mentioned location
  
  $pdf.render_file $pdfPath
  #Write Log
  if $generatelog == true
    $logger.info("#{$s} Ended")
  end
	
	$driver.quit
	$driver =nil

end


AfterStep do |scenario|
  
  #takeScreenShotOnEveryStep value will read from ENV file
  if  $takeScreenShotOnEveryStep == true
    @stepname=  @tests[@count].name
    $stepname = @stepname
    #Log generation
      if $generatelog == true
        $logger.info(@tests[@count].name)
      end
   
    @count += 1;
	@var = $s.to_s + "_#{Time.now.strftime('%Y_%m_%d_%H_%M_%S')}" + ".png"
	puts @var
    $driver.screenshot.save @var
    embed @var, 'image/png'
    @a = $s + @var
      if $j>0
       $pdf.start_new_page
      end
      @avatar = $folder + @var
     puts @avatar
    $pdf.text "Step:" + @stepname.to_s
    $pdf.text "Status: <color rgb='00CD00'>Pass</color>", :inline_format => true
    if File.exist?(@avatar) == true
      $pdf.image @avatar, :position => :center,:vposition => :center, :scale => 0.3
    else
      if $generatelog == true
      $logger.error("Expected screen shot not found in the current directory, so PDF Not generated")
      end
    end
    
    $i= $i+1
    $j=$j+1
  end

end
