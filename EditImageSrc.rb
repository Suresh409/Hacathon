 require 'fileutils'

 
 @k = File.expand_path('.')
	puts " Report current path : #{@k}"
	Dir.open(@k).each do |filename1|
		next if File.directory? filename1
			name = File.basename(filename1, '*.html')
			extn = File.extname  name
			puts extn
	 if extn == ".html"
		  text = File.read(filename1)
		  new_contents = text.gsub("../", "../ScreenShots/")

  # To merely print the contents of the file, use:

  # To write changes to the file, use:
  File.open(filename1, "w") {|file| file.puts new_contents }
  puts "Completed"
	 end
	end
