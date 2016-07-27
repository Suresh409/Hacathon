$url = "http://www.flipkart.com/"
require 'rubygems'
require 'rubyXL'
require 'Prawn'
require 'logger'
require 'time_diff'


require "selenium-webdriver"
require 'rubygems'
$wait = Selenium::WebDriver::Wait.new(:timeout => 30) 

$LOAD_PATH<< File.expand_path('../OR', 'flipkart.rb')
require 'flipkart'

$LOAD_PATH<< File.expand_path('../features/AndroidWeb/pages', 'common.rb')
require 'excel'
require 'common'
require 'fileutils'



$currentdir = File.expand_path('.')
$deviceBasedExcelPath = $currentdir + "/Results"
$sourcexl= $currentdir + "/config/" + "MasterSheet.xlsx"
$userInfoSheet = $currentdir + "/TestData/" + "TestData.xlsx"
$folder = File.expand_path('.')
$folder = $folder + "/"
$testDataPath = $currentdir + "/config/" + "/MasterSheet.xlsx"
$logfileFolderPath = $currentdir + "/Log/"
$source_ExcelFile_Path= File.join($currentdir, "config" ,"MasterSheet.xlsx")

$takeScreenShotOnEveryStep = true
$generatelog = true


