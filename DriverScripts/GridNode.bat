title grid node
cd %~dp0Selenium
java -jar selenium-server-standalone-2.45.0.jar -role node Confignode.json -hub http://localhost:4444/grid/console/register -port 5556  -Dwebdriver.chrome.driver="%~dp0Selenium\chromedriver.exe" -Dwebdriver.ie.driver="%~dp0Selenium\IEDriverServer.exe"
pause


