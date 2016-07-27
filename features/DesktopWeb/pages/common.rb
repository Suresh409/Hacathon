
class Common
	def Open
		$driver.goto"#{$url}"
	end
	
	def CreateObject(objname)
		objArry = objname.split(",")
		x = "#{objArry[1]}"
		y = "#{objArry[0]}"
		case y
		when "text_field"
			case x
				when "name"
				obj = $driver.text_field(:name, "#{objArry[2]}")
				puts "Object Created"
				puts obj
				when "id"
				obj = $driver.text_field(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.text_field(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.text_field(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.text_field(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.text_field(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.text_field(:link_text, "#{objArry[2]}")
				when "value"
				obj = $driver.text_field(:value, "#{objArry[2]}")
				when "text"
				obj = $driver.text_field(:text, "#{objArry[2]}")
				when "caption"
				obj = $driver.text_field(:caption, "#{objArry[2]}")				
				when "index"
				obj = $driver.text_field(:index, "#{objArry[2]}")
				else
				raise("Un defined property name for text_field")
				end
		when "button"
			case x
				when "name"
				obj = $driver.button(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.button(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.button(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.button(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.button(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.button(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.button(:link_text, "#{objArry[2]}")
				end
		when "radio"
			case x
				when "name"
				obj = $driver.radio(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.radio(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.radio(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.radio(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.radio(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.radio(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.radio(:link_text, "#{objArry[2]}")
				end		
		when "check_box"
			case x
				when "name"
				obj = $driver.check_box(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.check_box(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.check_box(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.check_box(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.check_box(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.check_box(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.check_box(:link_text, "#{objArry[2]}")
				end		
		when "select_list"
			case x
				when "name"
				obj = $driver.select_list(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.select_list(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.select_list(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.select_list(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.select_list(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.select_list(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.select_list(:link_text, "#{objArry[2]}")
				end							
		when "label"
			case x
				when "name"
				obj = $driver.label(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.label(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.label(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.label(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.label(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.label(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.label(:link_text, "#{objArry[2]}")
				end					
		when "span"
			case x
				when "name"
				obj = $driver.span(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.span(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.span(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.span(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.span(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.span(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.span(:link_text, "#{objArry[2]}")
				end					
						
		when "div"
			case x
				when "name"
				obj = $driver.div(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.div(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.div(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.div(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.div(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.div(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.div(:link_text, "#{objArry[2]}")
				end				
		when "p"
			case x
				when "name"
				obj = $driver.p(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.p(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.p(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.p(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.p(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.p(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.p(:link_text, "#{objArry[2]}")
				end				
		when "link"
			case x
				when "name"
				obj = $driver.link(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.link(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.link(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.link(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.link(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.link(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.link(:link_text, "#{objArry[2]}")
				end				
		when "table"
			case x
				when "name"
				obj = $driver.table(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.table(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.table(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.table(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.table(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.table(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.table(:link_text, "#{objArry[2]}")
				end					
		when "image"
			case x
				when "name"
				obj = $driver.image(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.image(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.image(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.image(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.image(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.image(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.image(:link_text, "#{objArry[2]}")
				end					
		when "form"
			case x
				when "name"
				obj = $driver.form(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.form(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.form(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.form(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.form(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.form(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.form(:link_text, "#{objArry[2]}")
				end					
		when "frame"
			case x
				when "name"
				obj = $driver.frame(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.frame(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.frame(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.frame(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.frame(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.frame(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.frame(:link_text, "#{objArry[2]}")
				end					
		when "area"
			case x
				when "name"
				obj = $driver.area(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.area(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.area(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.area(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.area(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.area(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.area(:link_text, "#{objArry[2]}")
				end																				
		when "li"
			case x
				when "name"
				obj = $driver.li(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.li(:id, "#{objArry[2]}")
				when "class"
				obj = $driver.li(:class, "#{objArry[2]}")
				when "css"
				obj = $driver.li(:css, "#{objArry[2]}")
				when "xpath"
				obj = $driver.li(:xpath, "#{objArry[2]}")
				when "tag_name"
				obj = $driver.li(:tag_name, "#{objArry[2]}")
				when "link_text"
				obj = $driver.li(:link_text, "#{objArry[2]}")
				end					
		when "h1"
			case x
				when "name"
				obj = $driver.h1(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.h1(:id, "#{objArry[2]}")
				when "index"
				obj = $driver.h1(:index, "#{objArry[2]}")
				when "xpath"
				obj = $driver.h1(:xpath, "#{objArry[2]}")
				else
				raise(" Un defined property name for h1")
				end						
		when "h2"
			case x
				when "name"
				obj = $driver.h2(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.h2(:id, "#{objArry[2]}")
				when "index"
				obj = $driver.h2(:index, "#{objArry[2]}")
				when "xpath"
				obj = $driver.h2(:xpath, "#{objArry[2]}")
				else
				raise(" Un defined property name for h2")
				end		
		when "h3"
			case x
				when "name"
				obj = $driver.h3(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.h3(:id, "#{objArry[2]}")
				when "index"
				obj = $driver.h3(:index, "#{objArry[2]}")
				when "xpath"
				obj = $driver.h3(:xpath, "#{objArry[2]}")
				else
				raise(" Un defined property name for h3")
				end		
		when "h4"
			case x
				when "name"
				obj = $driver.h4(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.h4(:id, "#{objArry[2]}")
				when "index"
				obj = $driver.h4(:index, "#{objArry[2]}")
				when "xpath"
				obj = $driver.h4(:xpath, "#{objArry[2]}")
				else
				raise(" Un defined property name for h4")
				end		
		when "h5"
			case x
				when "name"
				obj = $driver.h5(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.h5(:id, "#{objArry[2]}")
				when "index"
				obj = $driver.h5(:index, "#{objArry[2]}")
				when "xpath"
				obj = $driver.h5(:xpath, "#{objArry[2]}")
				else
				raise(" Un defined property name for h5")
				end		
		when "h6"
			case x
				when "name"
				obj = $driver.h6(:name, "#{objArry[2]}")
				when "id"
				obj = $driver.h6(:id, "#{objArry[2]}")
				when "index"
				obj = $driver.h6(:index, "#{objArry[2]}")
				when "xpath"
				obj = $driver.h6(:xpath, "#{objArry[2]}")
				else
				raise(" Un defined property name for h6")
				end		
		end
return obj

end
	def WaitForObject(objname,timevalue)
obj1 = CreateObject(objname)
		          for i in 0..timevalue 
                   sleep(0.5)
                          if obj1.exist?
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
		 if obj1.exists?
			obj1.send_keys(textValue)
		else
			raise("Object Not Found '#{objArry[1]}' :'#{objArry[2]}'")
		end
	end
	
	def Click(objname)
obj1 = CreateObject(objname)

		if obj1.exists?
			obj1.click
		else
			raise("Object Not Found '#{objArry[1]}' :'#{objArry[2]}'")
		end
	end

end
