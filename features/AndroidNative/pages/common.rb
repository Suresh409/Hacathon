
class Common
	def Open
		#$driver ||= start_app(platformName,platformVersion,deviceName,app,apppackage,appactivity)
		sleep 6
	end
	
	def CreateObject(objname)
		objArry = objname.split(",")
		lengthofarr1 = objArry.size


		x = "#{objArry[1]}"
		indexVal = objArry[3]
		case x
		when "name"
		obj = $driver.find_elements(:name, objArry[2])
		when "id"
		obj = $driver.find_elements(:id, objArry[2])
		when "class"
		obj = $driver.find_elements(:class, objArry[2])
		puts obj
		when "css"
		obj = $driver.find_elements(:css, objArry[2])
		when "xpath"
		obj = $driver.find_elements(:xpath, objArry[2])
		when "tag_name"
		obj = $driver.find_elements(:tag_name, objArry[2])
		when "link_text"
		obj = $driver.find_elements(:link_text, objArry[2])
		end
		if lengthofarr1 == 4
			return obj[indexVal.to_i]
		else
			return obj[0]
		end
end
	
	def WaitForObject(objname,timevalue)
	
	$driver.rotate :portrait
		obj1 = CreateObject(objname)
	 for i in 0..timevalue 
                   sleep(0.5)
                          if obj1.displayed?
                           break
                            else
                              puts "Waiting for object to presenrt in screen...."
                          end 
                          if i == timevalue
                              raise("Time out error..Object Not Found '#{objArry[1]}' :'#{objArry[2]}' with in the given time") 
                          end 
                 end 
	end
	
	def Input(objname,textValue)
		obj1 = CreateObject(objname)
		if obj1.displayed?
			obj1.send_keys(textValue)
		else
			raise("Object Not Found.. #{objArry[1]} ,#{objArry[2]}")
		end
	end
	
	def Click(objname)
		obj1 = CreateObject(objname)
		if obj1.displayed?
		obj1.click
		else
		raise("Object Not Found.. #{objArry[1]} ,#{objArry[2]}")
		end
	end
		
	def VerifyObjectExist(objname)
		obj1 = CreateObject(objname)
		if obj1.displayed?
		return true
		else
		return false
		end
	
	end
	
	
end
