require './lara_object.rb'
require './base_object.rb'
require 'selenium-webdriver'

PHOTON_RADIO = {xpath: './/label[contains(@for,"select-model-3")]'}
PHOTON_CHECKBOX = {xpath: './/label[contains(@for,"ke-shading")]'}
SHOW_ATOM_CHECKBOX = {xpath: './/label[contains(@for,"select-show-atoms")]'}
SHOW_ELECTRON_CLOUD = {xpath: './/label[contains(@for,"select-electron-view-1")]'}
HAS_DROPDOWN = {css: '.selectboxit-options'}
HAS_DROPDOWN_SELECTION_LIST = {xpath: "//li[contains(@class,'selectboxit-option')]/a/text()"}
HAS_ADD_WELL = {id: "add-wells-button-set"}
HAS_MAIN_IMAGE = {id: '#mouse-catcher'}
HAS_INTRO_CLOSE = {xpath: '//div[contains(@class,"about-dialog")]/div/button[contains(@class,"ui-dialog-titlebar-close")]'}

url = 'http://authoring.staging.concord.org/activities/762/'

links = []

learn = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(url)
learn.verify_activity('Shutterbug Smoke Test')

pages = learn.get_pages()
# puts "pages are #{pages}"
pages.each do |page|
  link = learn.get_link(page)
  link.slice! url
  links<<link
end
# puts "links are #{links}"

links.shift # removes the home page of the shutterbug activity

#Fails at Page 12 because have to make a drawing first and then take a snapshot/ Look for "Drawing tool drawing?"
links.each do |link|
  learn.visit(url+link)
  sleep(5)
  #check which page to know what to do at each page
  page_title = learn.get_page_title
  puts "Page_title is #{page_title}"
  case (page_title)
    # when /Drawing/
    #   learn.open_draw_tool
    #   learn.draw_shape
    #   learn.close_draw_tool
    # when /Molecular Workbench/
    #   learn.switch_to_interactive
    #   learn.play_interactive
    #   sleep(2)
    #   learn.switch_to_main
    # when /Photons/
    #   learn.switch_to_interactive
    #   learn.click_on(PHOTON_RADIO)
    #   learn.click_on(PHOTON_CHECKBOX)
    #   learn.play_interactive
    #   sleep(2)
    #   learn.switch_to_main
    # when /Balloon Charge/
    #   learn.switch_to_interactive
    #   learn.click_on(SHOW_ATOM_CHECKBOX)
    #   learn.click_on(SHOW_ELECTRON_CLOUD)
    #   sleep(2)
    #   learn.switch_to_main
    # when /Model with text/
    #   learn.switch_to_interactive
    #   learn.play_interactive
    #   sleep(2)
    #   learn.switch_to_main
    when /HAS water/
      puts "In HAS water"
      learn.switch_to_interactive
      learn.click_on(HAS_INTRO_CLOSE)
      learn.select_from_dropdown(HAS_DROPDOWN,HAS_DROPDOWN_SELECTION_LIST,"Rural")
      learn.click_on(HAS_ADD_WELL)
      learn.click_hold(HAS_MAIN_IMAGE,2)
      learn.play_interactive
      learn.switch_to_main
      puts "before take_snapshot"
      learn.take_snapshot
      sleep(5)

  end
  # puts "before take_snapshot"
  # learn.take_snapshot
  # sleep(5)
end



# page 1 gradient colors - take snapshot
# page 2 draw tool (Make a drawing), draw tool (Take a snapshot)
# page 3 Molecular Workbench Lab - click play button, take snapshot
# page 4 Model with image - Photons - turn on radio button, turn on checkbox, click play button, take snapshot
# page 5 CODAP - take a snapshot
# page 6 Balloon Charge - turn on checkbox, turn on  radio button take snapshot
# page 7 Text in ineractive - click play button, take snapshot
# page 8 HAS Water interactive - select from dropdown menu, add well, click play button, take snapshot
# page 9 JSMol interactive - take snapshot
# page 10 ITSI model with line graph - click grass, rabbit, hawk, fox buttons, click play button, take snapshot
# page 11 ITSI model with bar graph - click grass, rabbit buttons, click play button, take snapshot
# page 12 ITSI Biologica model - click mother end button, click circle, father end button, click circle, offspring end button, take snapshot
# page 13 iSense - take snapshot
# page 14 Labbook - take snapshot, (open album, verify snapshot in album)
# page 15 Labbook no interactive - verify no snapshot button
# page 16 Snapshot of an image - take snapshot
# page 17 Snapshot of video - take snapshot, verify error message comes up
# page 18 PhET - take snapshot
# page 19 Prediction graph - draw line, take snapshot
# page 20 Convection in house - click play button, take snapshot
# page 21 Interactive table - type in text to four tds, take snapshot
# page 22 Netlogo model - click run button, move planet, take snapshot
# page 23 Sensor connector - click cancel in alert, take snapshot
# page 24 Completion page