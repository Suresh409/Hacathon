require 'securerandom'

class Generic
   def randomNumber(length)
   @sysDateAndTime = nil
    #create time object
    time1 = Time.new
    #getting present system time
     @sysDateAndTime = time1.inspect
     #puts "System date and time : #@sysDateAndTime"
     #Creating String object
        completeText = String.new(@sysDateAndTime)  
   #removing hyphen from system date and time
        replace_hyphen= completeText.gsub("-","")
   #removing colon from system date and time
        replace_colon = replace_hyphen.gsub(":","")
   #removing plus from system date and time     
        replace_plus = replace_colon.gsub("+","")
   #removing space from system date and time
        remove_space = replace_plus.gsub(" ","")

   #getting 13 digit unique account number      
        accountnumber = remove_space[3,length]
	@number = accountnumber
        #puts $number
		return @number
	end

def randomString(length)
  @string = ""
  chars = ("a".."z").to_a
  length.times do
    @string << chars[rand(chars.length-1)]
  end
 return @string
end
 


  def randomAlphaNumaric(length)
      @alphaNumaric = SecureRandom.base64(length).delete('/+=')[0, length]
return @alphaNumaric
  end

end