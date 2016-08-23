--FDSTUDIOS PRESENTS:
--Wuizapp example
--Main.lua
------------------------------------------------------------

-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
local composer = require "composer"
local buttons = require("hud")
--local licensing = require("licensing")
--licensing.init("google")
local showButtons
local hideButtons

--Since this is in main.lua, it will be shown on every scene
local hud = display.newImageRect( "bg.png", display.actualContentWidth, display.actualContentHeight )
	hud.x = display.contentCenterX
	hud.y = display.contentCenterY
	hud:toBack()

local image = display.newImageRect("app_loading_screen.png", display.actualContentWidth*0.92, display.actualContentHeight*0.9)
	image.anchorX = 0
	image.anchorY = 0
	image.x = display.contentCenterWidth
	image.x = image.x + 16
	image.y = display.contentCenterHeight
	image.y = image.y + 10	

	local backbutton, nextbutton, textbutton
	local wh = display.contentWidth*0.16

--REMOVED FOR IOS BUILD
-- local function licensingListener( event )

--     if not ( event.isVerified ) then
--         -- Failed to verify app from the Google Play store; print a message
--         local pirated = display.newImage("pirated.png", display.contentCenterWidth, display.contentCenterHeight)
--         pirated:toFront() 
--     end
-- end
	
local function main()	
transition.to(image, {alpha = 0, time = 700, onComplete=function() image:removeSelf() end})
	buttons:createButtons()
composer.gotoScene( "levelselect", "fade", 1000 )

end

timer.performWithDelay(4000,main)