
class Common
	def Open
		$driver.get($url)
	end
	def CreateObject(objname)
		objArry = objname.split(",")
		x = "#{objArry[1]}"
		case x
		when "name"
		obj = $driver.find_element(:name, objArry[2])
		when "id"
		obj = $driver.find_element(:id, objArry[2])
		when "class"
		obj = $driver.find_element(:class, objArry[2])
		puts obj
		when "css"
		obj = $driver.find_element(:css, objArry[2])
		when "xpath"
		obj = $driver.find_element(:xpath, objArry[2])
		when "tag_name"
		obj = $driver.find_element(:tag_name, objArry[2])
		when "link_text"
		obj = $driver.find_element(:link_text, objArry[2])
		end
return obj
end
	
	
	
	
	
	
	
	
	
	
	
	
	def WaitForObject(objname,timevalue)
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
			raise("Object Not Found '#{objArry[1]}' :'#{objArry[2]}'")
		end
	end
	
		def Click(objname)
		obj1 = CreateObject(objname)
		if obj1.displayed?
			obj1.click
		else
			raise("Object Not Found '#{objArry[1]}' :'#{objArry[2]}'")
		end
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	def VerifyObjectExist(objname)
		objArry = objname.split(",")
		x = "#{objArry[1]}"
		case x
		when "name"
		obj = $driver.find_element(:name, objArry[2])
		when "id"
		obj = $driver.find_element(:id, objArry[2])
		when "class"
		obj = $driver.find_element(:class, objArry[2])
		when "css"
		obj = $driver.find_element(:css, objArry[2])
		when "xpath"
		obj = $driver.find_element(:xpath, objArry[2])
		when "tag_name"
		obj = $driver.find_element(:tag_name, objArry[2])
		when "link_text"
		obj = $driver.find_element(:link_text, objArry[2])
		end
		if obj.displayed?
			return true
		else
			return false
		end
	end
	
	
end
