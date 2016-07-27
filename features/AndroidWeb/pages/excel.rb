
class Excel


	def readBasedOnString(searchString,sheetNumber)
	begin
		@searchStringFoundInRow = nil	
		col = 0
		@readWorkbook = RubyXL::Parser.parse($userInfoSheet)
		@readSheet=@readWorkbook[sheetNumber]
		if @readSheet
			totalUsedRows = @readSheet.sheet_data.size
			  
			for rowNum in 0...totalUsedRows
						
				cellValue = @readSheet[rowNum][col].value
				if cellValue.to_s.strip == searchString.to_s.strip
				  @searchStringFoundInRow= rowNum
				end
				#verify Row number is not null
				if @searchStringFoundInRow != nil
				 @userName_var = @readSheet[@searchStringFoundInRow][1].value
				 @passWord_var = @readSheet[@searchStringFoundInRow][2].value 
				end
					 
					
					
			end

				if @searchStringFoundInRow != nil
						return [@userName_var,@passWord_var]
				else
						return "Row not Found"
				end
		  
		end	
	rescue => err
	raise("Excel Read fail: '#{err}'")
    
	end	 
end



	def readBasedOnRowandCol(row,col,sheetNumber)

		cellValue = nil
		@readWorkbook = RubyXL::Parser.parse($userInfoSheet)
		@readSheet = @readWorkbook[sheetNumber]
			if @readSheet
				 cellValue = @readSheet[row][col].value
			else
				raise("Sheet not Found")
			end
		return cellValue
	end
		
#This Write method is used to Update the Result Status in the Excel 

	def Write(status,madulename,path,linkName,resultxlPath)
	begin
			@x = "\"#{path}\""
			@y = "\"#{linkName}\""
			$resultExcelPath = "#{resultxlPath}" + "/" + "#{$current_feature}" + "-" +"#{$deviceID}"+ "-" + $deviceType.to_s + ".xlsx"
			@mName = "#{madulename.to_s.strip}"
			@workbook = RubyXL::Parser.parse($resultExcelPath)
			@moduleSheet2 = @workbook[madulename.to_s.strip]
			  @rowCount  = @moduleSheet2.sheet_data.size
				k=0
					if $completeScenario.include? ","

							@tcArray = $completeScenario.split(",")
							@tcCount = @tcArray.length
						for tc in 0..@tcCount.to_i-1
							$tcid = @tcArray[tc]
							for k in 1..@rowCount.to_i-1		
								if @moduleSheet2[k][0]
													@CellValue = @moduleSheet2[k][1].value
													if @CellValue.strip == $tcid.strip
														
															@moduleSheet2.add_cell(k, 3, status)
												
															if status== 'Pass'
																	
																@moduleSheet2.sheet_data[k][3].change_fill('0ba53d')
													
															else
															@moduleSheet2.sheet_data[k][3].change_fill('a50b26')
															end
																@moduleSheet2.add_cell(k, 4,'',"HYPERLINK(#{@x}, #{@y})")
																@moduleSheet2.sheet_data[k][4].change_border(:top, 'thin')
																@moduleSheet2.sheet_data[k][4].change_border(:bottom, 'thin')
																@moduleSheet2.sheet_data[k][4].change_border(:left, 'thin')
																@moduleSheet2.sheet_data[k][4].change_border(:right, 'thin')
																@moduleSheet2.sheet_data[k][4].change_font_color(font_color = '277BD5')
																@workbook.write($resultExcelPath)
															break
													end
													
								end
							end
						end
								
								
					else
						for k in 1..@rowCount
								@CellValue = @moduleSheet2[k][1].value
							if @CellValue.strip == $completeScenario.strip
									@moduleSheet2.add_cell(k, 3, status)
									if status== 'Pass'
										@moduleSheet2.sheet_data[k][3].change_fill('0ba53d')
									  
									else
										@moduleSheet2.sheet_data[k][3].change_fill('a50b26')
									end
										@moduleSheet2.add_cell(k, 4,'',"HYPERLINK(#{@x}, #{@y})")
										@moduleSheet2.sheet_data[k][4].change_border(:top, 'thin')
										@moduleSheet2.sheet_data[k][4].change_border(:bottom, 'thin')
										@moduleSheet2.sheet_data[k][4].change_border(:left, 'thin')
										@moduleSheet2.sheet_data[k][4].change_border(:right, 'thin')
										@moduleSheet2.sheet_data[k][4].change_font_color(font_color = '277BD5')
										@workbook.write($resultExcelPath)
										
									break
							end


						end




					end
	rescue => err
	raise("Excel operations fail: '#{err}'")
    
	end	 
					
end
	
	
	
	def WriteTime(timeValue,columnNO,madulename,resultxlPath)
	begin
			$resultExcelPath = "#{resultxlPath}" + "/" + "#{$current_feature}" + "-" +"#{$deviceID}" + "-" + $deviceType.to_s + ".xlsx"
			@mName = "#{madulename.to_s.strip}"
			@workbook = RubyXL::Parser.parse($resultExcelPath)
			@moduleSheet2 = @workbook[madulename.to_s.strip]
			  @rowCount  = @moduleSheet2.sheet_data.size
				k=0
					if $completeScenario.include? ","
							@tcArray = $completeScenario.split(",")
							@tcCount = @tcArray.length

						for tc in 0..@tcCount.to_i-1
							$tcid = @tcArray[tc]
							for k in 1..@rowCount.to_i-1		
								if @moduleSheet2[k][0]
													@CellValue = @moduleSheet2[k][1].value
													if @CellValue.strip == $tcid.strip
														
															@moduleSheet2.add_cell(k, columnNO, timeValue)
															@moduleSheet2.sheet_data[k][columnNO].change_border(:top, 'thin')
															@moduleSheet2.sheet_data[k][columnNO].change_border(:bottom, 'thin')
															@moduleSheet2.sheet_data[k][columnNO].change_border(:left, 'thin')
															@moduleSheet2.sheet_data[k][columnNO].change_border(:right, 'thin')
															@workbook.write($resultExcelPath)
														break
													end
													
								end
							end
						end
								
								
					else
						for k in 1..@rowCount
								@CellValue = @moduleSheet2[k][1].value
							if @CellValue.strip == $completeScenario.strip
									@moduleSheet2.add_cell(k, columnNO, timeValue)
									@moduleSheet2.sheet_data[k][columnNO].change_border(:top, 'thin')
									@moduleSheet2.sheet_data[k][columnNO].change_border(:bottom, 'thin')
									@moduleSheet2.sheet_data[k][columnNO].change_border(:left, 'thin')
									@moduleSheet2.sheet_data[k][columnNO].change_border(:right, 'thin')
									@workbook.write($resultExcelPath)		
									break
							end


						end

					end
	
	rescue => err
	raise("Excel operations fail: '#{err}'")
    
	end	 
	
	end


	
end