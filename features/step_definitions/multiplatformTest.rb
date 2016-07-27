
Given(/^I am on the Home Page$/) do
	$common = Common.new()
	$common.Open
	$common.WaitForObject($textbox,10)
	sleep 3
	end
Then (/^Search the Product as camera$/) do
	$common.Input($textbox,"Camera")
	@deviceType = ENV['DEVICE_TYPE']
	puts @deviceType
	if @deviceType.include? "Web"
		$common.Click($btn)
	else
		$common.Click($btn1)
	end
	sleep 3
end