#######################################################################################
# This script will read the input data from Excel and creates calabash commands to run
#
# Author: Suresh Reddy
#
# Initial Version: 08-Feb-2016
#######################################################################################
require 'win32ole'
require 'rubyXL'
require 'fileutils'
require 'axlsx'
require 'date'
require 'rubygems'
require 'find'

#Create TimeStamp
	time1 = Time.now
	@year = time1.year
	@month = time1.month
	@date = time1.day
	@hour = time1.hour
	@min = time1.min
	@sec = time1.sec
	@date = @date
	todayDateWithHour = @year.to_s + "_" + @month.to_s + "_" + @date.to_s + "_" + @hour.to_s + "_" +@min.to_s
	$todayDate = @year.to_s + "_" + @month.to_s + "_" + @date.to_s


#Declaring All Excel file paths using relative path
	$currentdir = File.expand_path('.')
	$source_ExcelFile_Path= File.join($currentdir, "config" ,"MasterSheet.xlsx")
	puts $source_ExcelFile_Path
	$ymlFilePath = File.join($currentdir, "config","cucumber.yml")
	puts $ymlFilePath
	$configFilePath = File.join($currentdir,"config","config.rb")
	puts $configFilePath
	$resultspath = File.join($currentdir,"Results")
	puts $resultspath
	$createResultsFolder = File.join($currentdir,"Results")
	puts $createResultsFolder
	$logFolder = File.join($currentdir,"Log")
	puts $logFolder
	$screenShotFolder = File.join($currentdir,"Screenshots")
	$reportsFolder = File.join($currentdir,"Reports")
	$editSrc = File.join($currentdir,"EditImageSrc.rb")
	$screenShotpath = File.join($currentdir,"Screenshots")	
	$report_ExcelFile_Path= File.join($currentdir,"Results")
	puts $report_ExcelFile_Path
	@dashBoardPath = File.join($currentdir,"Results", "MobileAutomationExecutionStatus.xlsx")
	$dummySheet = File.join($currentdir,"Results","MobileAutomationExecutionStatus.xlsx")
	@excelfile = "OverallExecuionReport" + "_" + $todayDate.to_s + ".xlsx"
	$dashboardPath = File.join($currentdir,"Results",@excelfile)
	puts $dashboardPath
	@attachmentsPath = File.join($currentdir,"Results")
	@dashBoardExcel = File.join($currentdir,"Results",@excelfile)
	puts @dashBoardExcel
	$backup =File.join($currentdir,"Backup")
	puts $backup
	@sourceWorkbook = RubyXL::Parser.parse($source_ExcelFile_Path)
	@moduleSheet=@sourceWorkbook["Modules"]
	$lostExecutionTime = @moduleSheet[0][30].value
	@resultfilename = "Results_" + "#{$lostExecutionTime.to_s}"
	$backupfolder = File.join($currentdir,"Backup",@resultfilename)
	
	#Create Folder with Last execution date and time in Backup and move all previous results to that folder
	Dir.mkdir($backup) unless File.exists?($backup) 
	if File.exists?($backupfolder) == true
	@resultfilename = "Results_" + "#{$lostExecutionTime.to_s}" + "_" + "#{@sec.to_s}"
	$backupfolder = File.join($currentdir,"Backup",@resultfilename)
	end
	if File.exists?($reportsFolder) == true
		if (Dir.entries($reportsFolder) - %w{ . .. }).empty? == true
			puts "Reports folder already exist with out any data, No need to Move to backup and create again"
		else
			FileUtils.mv($reportsFolder, $backupfolder)
			FileUtils::mkdir_p $reportsFolder
			FileUtils.cp($editSrc, $reportsFolder)
		end
	else
	FileUtils::mkdir_p $reportsFolder
	FileUtils.cp($editSrc, $reportsFolder)
	end
	
	if File.exists?($resultspath) == true
		if (Dir.entries($resultspath) - %w{ . .. }).empty? == true
			puts "Results folder already exist with out any data, No need to Move to backup and create again"
		else
			FileUtils.mv($resultspath, $backupfolder)
			FileUtils::mkdir_p $createResultsFolder
		end
	else
		FileUtils::mkdir_p $createResultsFolder
	end
	
	if File.exists?($logFolder) == true
		if (Dir.entries($logFolder) - %w{ . .. }).empty? == true
			puts "Logs folder already exist with out any data, No need to Move to backup and create again"
		else
			FileUtils.mv($logFolder, $backupfolder)
			FileUtils::mkdir_p $logFolder
		end
	else
		FileUtils::mkdir_p $logFolder
	end
	
	if File.exists?($screenShotFolder) == true
		if (Dir.entries($screenShotFolder) - %w{ . .. }).empty? == true
			puts "Screen shots folder already exist with out any data, No need to Move to backup and create again"
		else
			FileUtils.mv($screenShotFolder, $backupfolder)
			FileUtils::mkdir_p $screenShotFolder
		end
	else
		FileUtils::mkdir_p $screenShotFolder
	end
	
	if File.exists?($ymlFilePath) == true
		FileUtils.mv($ymlFilePath, $backupfolder)
		File.new($ymlFilePath, "a+")
	else
		File.new($ymlFilePath, "a+")
	end
	
	puts "Requirted folder created Successfully...."
	
	#Accessing Input workbook to get the modules information 
	@sourceWorkbook = RubyXL::Parser.parse($source_ExcelFile_Path)
	#Delete Sheet
	lengthOfSheets = @sourceWorkbook.worksheets.length
	@sourceWorkbook.worksheets.delete_at(lengthOfSheets-1)
	@sourceWorkbook.write($source_ExcelFile_Path)
	#Access Module Sheet
	@moduleSheet=@sourceWorkbook["Modules"]
	$totalOfRowsInModule = @moduleSheet.sheet_data.size
	puts $totalOfRowsInModule
	@cmdmoduleSheet=@sourceWorkbook.add_worksheet("Commands")
	@cmdLineCount = 0
	@moduleSheet.add_cell(0, 30, todayDateWithHour)
	@sourceWorkbook.write($source_ExcelFile_Path)
	
	#Writing Default Profuiles ro cucumber.yml file
	begin
		#opening file with read/Write/Append mode
		file = File.open($ymlFilePath, "a")
		file.write("android: -r features/AndroidNative/support -r features/step_definitions -r features/AndroidNative/pages/ " + "\n")
		file.write("iOS: -r features/IosNative/support -r features/step_definitions -r features/IosNative/pages/ " + "\n") 
		file.write("androidWeb: -r features/AndroidWeb/support -r features/step_definitions -r features/AndroidWeb/pages/ " + "\n") 
		file.write("iOSWeb: -r features/iOSWeb/support -r features/step_definitions -r features/iOSWeb/pages/ " + "\n") 
		file.write("desktopWeb: -r features/DesktopWeb/support -r features/step_definitions -r features/DesktopWeb/pages/ " + "\n") 
	rescue IOError => e
	puts "some error occur, dir not writable etc."
	puts e
	ensure
	file.close unless file.nil?
	end
	 
	 
	 
	 
	begin
    file = File.new($configFilePath, "r")
    while (line = file.gets)
        @linetext = "#{line}"
    	
		if @linetext.include? "apkName"
			@apknameArr = @linetext.split("=")
			@apkName = @apknameArr[1]
		end	
		if @linetext.include? "ipaName"
			@ipanameArr = @linetext.split("=")
			@ipaName = @ipanameArr[1]
		end			
	
		
end
    file.close
rescue => err
    puts "Exception: #{err}"
    err
end
	
for i in 1...$totalOfRowsInModule
		#Getting Device ID from Input Workbook
		@DEVICEID = @moduleSheet[i][2].value
		@browserName = @moduleSheet[i][4].value
		@deviceType = @moduleSheet[i][3].value
		
		if @deviceType == "Android"
			@cmdpath = "bundle exec cucumber -p android " 
		@platformName = @moduleSheet[i][5].value
		@platformVersion = @moduleSheet[i][6].value
		@app = @moduleSheet[i][7].value
		@apppackage = @moduleSheet[i][8].value
		@appactivity = @moduleSheet[i][9].value
		@serverUrl = @moduleSheet[i][10].value
		elsif @deviceType == "iOS"
			@cmdpath = "bundle exec cucumber -p iOS "
		@platformName = @moduleSheet[i][5].value
		@platformVersion = @moduleSheet[i][6].value
		@app = @moduleSheet[i][7].value
		@apppackage = @moduleSheet[i][8].value
		@appactivity = @moduleSheet[i][9].value
		@serverUrl = @moduleSheet[i][10].value
		elsif @deviceType == "AndroidWeb"
			@cmdpath = "bundle exec cucumber -p androidWeb "
		@platformName = @moduleSheet[i][5].value
		@platformVersion = @moduleSheet[i][6].value
		@app = @moduleSheet[i][7].value
		@apppackage = @moduleSheet[i][8].value
		@appactivity = @moduleSheet[i][9].value
		@serverUrl = @moduleSheet[i][10].value
		elsif @deviceType == "iOSWeb"
			@cmdpath = "bundle exec cucumber -p iOSWeb "
		@platformName = @moduleSheet[i][5].value
		@platformVersion = @moduleSheet[i][6].value
		@app = @moduleSheet[i][7].value
		@apppackage = @moduleSheet[i][8].value
		@appactivity = @moduleSheet[i][9].value
		@serverUrl = @moduleSheet[i][10].value
		elsif @deviceType == "DesktopWeb"
			@cmdpath = "cucumber -p desktopWeb "
		elsif @deviceType == "FirefoxOS"
			@cmdpath = "bundle exec cucumber -p desktopWeb "
		@platformName = @moduleSheet[i][5].value
		@platformVersion = @moduleSheet[i][6].value
		@app = @moduleSheet[i][7].value
		@apppackage = @moduleSheet[i][8].value
		@appactivity = @moduleSheet[i][9].value
		@serverUrl = @moduleSheet[i][10].value
		elsif @deviceType == "FirefoxOSWeb"
			@cmdpath = "bundle exec cucumber -p desktopWeb "
		@platformName = @moduleSheet[i][5].value
		@platformVersion = @moduleSheet[i][6].value
		@app = @moduleSheet[i][7].value
		@apppackage = @moduleSheet[i][8].value
		@appactivity = @moduleSheet[i][9].value
		@serverUrl = @moduleSheet[i][10].value
		end
		@taglist = "--tags"
			
			@moduleExecutionStatus = @moduleSheet[i][1].value
		if @moduleExecutionStatus == "Y"
						@cmdLineCount = @cmdLineCount+1
						@modulename = @moduleSheet[i][0].value
						
						@sourceWorkbook.worksheets.each do |m|
						@sheetName = " #{m.sheet_name}"
				if @modulename.to_s.downcase.strip == @sheetName.to_s.downcase.strip
				@excel_resultFile = $resultspath.to_s + "/" + @modulename.to_s + "-" + @DEVICEID.to_s + "-" + @deviceType.to_s + ".xlsx"
				workbook1 = RubyXL::Workbook.new
				sheet2 = workbook1.worksheets[0]
				sheet2.sheet_name = @sheetName.to_s.strip
				@sourceSheet= @sourceWorkbook[@sheetName.to_s.strip]
				puts "Acessing #{@sheetName} cells as rectangular array..."
				@sourceSheet.sheet_data.size.times do |n|
					currentRow = @sourceSheet[n][1].value
					currentRow.size.times do |o|
						if @sourceSheet[n][o]
						  @rowvalue = @sourceSheet[n][o].value	
						  sheet2.add_cell(n, o, @rowvalue)
						  sheet2.sheet_data[n][o].change_border(:top, 'thin')
						  sheet2.sheet_data[n][o].change_border(:bottom, 'thin')
						  sheet2.sheet_data[n][o].change_border(:left, 'thin')
						  sheet2.sheet_data[n][o].change_border(:right, 'thin')
						  sheet2.sheet_data[0][o].change_fill('277BD5')
						  workbook1.write(@excel_resultFile)
						  o =3
						end

					end
					
				end
				break
				"Created out put file for #{@sheetName.to_s.strip}"
				
			end
			
		  end
			
			#Creating tags list for all test cases which are mentioned execution status as yes
			@sourceWorkbook.write($source_ExcelFile_Path)
			moduleNameSheet=@sourceWorkbook[@modulename]
			$totalNumberOfTestCases = moduleNameSheet.sheet_data.size
				for j in 1...$totalNumberOfTestCases
						
					@tcExecutionStatus = moduleNameSheet[j][2].value
					if @tcExecutionStatus == "Y"
						@tcID = moduleNameSheet[j][1].value
						@taglist = @taglist.to_s + "," + "@" + @tcID.to_s
					end
							
				end
			@taglist= @taglist.sub(","," ")
				begin
					#opening file with read/Write/Append mode
					file = File.open($ymlFilePath, "a")
					file.write(@modulename.to_s + ": " + @taglist.to_s + "\n") 
					@taglist = nil
				rescue IOError => e
					puts "some error occur, dir not writable etc."
					puts e
				ensure
					file.close unless file.nil?
				end
			# Creating Command with report formate and report path ect...
			if @deviceType == "DesktopWeb"
			@calabashCommand = @cmdpath.to_s + " -p " + @modulename.to_s + " -f html " + " -o " + "./Reports/" + @modulename.to_s + "_" + "#{@DEVICEID}" + "_" + "#{@deviceType}" +".html" + " BROWSER=" + "#{@browserName}" + " DEVICE_TYPE=" + "#{@deviceType}" + " DEVICE_ID=" + "#{@DEVICEID}"
			elsif @deviceType.include? "Web"
			@calabashCommand = @cmdpath.to_s + " -p " + @modulename.to_s + " -f html " + " -o " + "./Reports/" + @modulename.to_s + "_" + "#{@DEVICEID}" + "_" + "#{@deviceType}" +".html" + " DEVICE_TYPE=" + "#{@deviceType}" + " DEVICE_ID=" + "#{@DEVICEID}" + " PLATFORMNAME=" + "#{@platformName}" + " PLATFORMVERSION=" + "#{@platformVersion}" + " APP=" + "#{@app}" + " DEVICENAME=" + "#{@DEVICEID}" +  " SERVERURL=" + "#{@serverUrl}"
			else
			@calabashCommand = @cmdpath.to_s + " -p " + @modulename.to_s + " -f html " + " -o " + "./Reports/" + @modulename.to_s + "_" + "#{@DEVICEID}" + "_" + "#{@deviceType}" +".html" + " DEVICE_TYPE=" + "#{@deviceType}" + " DEVICE_ID=" + "#{@DEVICEID}" + " PLATFORMNAME=" + "#{@platformName}" + " PLATFORMVERSION=" + "#{@platformVersion}" + " APP=" + "#{@app}" + " DEVICENAME=" + "#{@DEVICEID}" + " PACKAGENAME=" + "#{@apppackage}" + " ACTIVITYNAME=" + "#{@appactivity}" +  " SERVERURL=" + "#{@serverUrl}"
			end
		end		
					
					@cmdmoduleSheet.add_cell(@cmdLineCount, 0, @calabashCommand)
					@sourceWorkbook.write($source_ExcelFile_Path)
						

 end
 puts "Successfully Created Commands to run Tests based on Excel data.."
 
 
  
 
 ####################################################################################
 # This Script will read commands sheets which is added to input sheet in run time.
 # It will execute the commands in the specified execution mode like Serial/Parallel.
 # You must select the execution mode in input sheet
 ####################################################################################
 
 
 
 
 
  
 	@sourceWorkbook = RubyXL::Parser.parse($source_ExcelFile_Path)
	@moduleSheet=@sourceWorkbook["Modules"]
	
	begin
    file = File.new($configFilePath, "r")
    while (line = file.gets)
        @linetext = "#{line}"
    	
		if @linetext.include? "executionMode"
			@exemode = @linetext.split("=")
			@executionMode = @exemode[1]
		break
		end		
	
		
end
    file.close
rescue => err
    puts "Exception: #{err}"
    err
end
	
	puts "Execution mode is #{@executionMode}"
	
if @executionMode.to_s.strip == "Serial"
			puts "Execution Started in #{@executionMode} mode...."
			@commandsSheet=@sourceWorkbook["Commands"]
			$totalNumberOfCopmmands = @commandsSheet.sheet_data.size
	for c in 1...$totalNumberOfCopmmands
			puts " Getting Data from Commands Sheet..."
			@cmdValue = @commandsSheet[c][0].value
			system(@cmdValue)
	 end
 
 puts "Execution completed...."
end


if @executionMode.to_s.strip == "Parallel"
			@totalDevicesConnected = 3
			puts "Execution Started in #{@executionMode} mode...."
			@commandsSheet=@sourceWorkbook["Commands"]
			$totalNumberOfCopmmands = @commandsSheet.sheet_data.size
			puts "Total number of commands #{$totalNumberOfCopmmands}"
	for c in 1...@totalDevicesConnected.to_i-1
	@cmdList  ||= []
	@cmd = @commandsSheet[c][0].value
	@cmdList << @cmd
	
				if c == 1
						puts " Getting Data from Commands Sheet..."
						@cmd1 = @commandsSheet[c][0].value
						puts @cmd1
				end
				if c == 2
						puts " Getting Data from Commands Sheet..."
						@cmd2 = @commandsSheet[c][0].value
						puts @cmd2
				end	
				if c == 3
						puts " Getting Data from Commands Sheet..."
						@cmd3 = @commandsSheet[c][0].value
						#puts @cmd3
				end					
			
				if c == 4
						puts " Getting Data from Commands Sheet..."
						@cmd4 = @commandsSheet[c][0].value
						#puts @cmd4
				end					
				if c == 5
						puts " Getting Data from Commands Sheet..."
						@cmd5 = @commandsSheet[c][0].value
						#puts @cmd5
				end					
				
				
				
	 end
	 
	 	#Create Thread
		t1 = Thread.new do
		  %x[#{@cmd1}]
		end
		#t2 = Thread.new do
		#  %x[#{@cmd2}]
		#end
		%x[#{@cmd2}]
		t1.join
		#t2.join
	

		 puts "Execution completed...."
end



################################################################
#This Script Will Move all the screen shots to Screen shots folder.
################################################################

# Move Screen shots to Screen shots folder
				 
	puts " Screen shot destination path is : #{$screenShotpath}"
	@c = File.expand_path('.')
	puts " Screen shot current path : #{@c}"
	Dir.open(@c).each do |filename|
		next if File.directory? filename
			name = File.basename(filename, '*.pdf')
			$source_File_Path	= @c
			$source_File_Path = $source_File_Path + "/" + name.to_s
			extn = File.extname  name
	 if extn == ".png"
		FileUtils.mv $source_File_Path, $screenShotpath
		puts "Screen shot Moved to : #{$screenShotpath}"
	 end
	end
