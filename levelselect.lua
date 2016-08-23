---------------------------------------------------------------------------------
--
-- levelselect.lua
-- Quizapp Example
-- App Open -> Level select -> Level Menu -> listen/read storyquizmenu -> listen/read storyquiz
---------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local buttons = require("hud")

system.setIdleTimer( true )
---------------------------------------------------------------------------------
-- BEGINNING OF IMPLEMENTATION
---------------------------------------------------------------------------------

local image, level1, level2, level3

-- Touch event listener for background image
local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		composer.gotoScene( "scene2", "slideLeft", 800  )
		
		return true
	end
end


-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	
	local contentScreen = display.newImageRect( "content_screen.png", display.actualContentWidth, display.actualContentHeight*0.85)
	contentScreen.x, contentScreen.y = display.contentWidth/2, display.contentHeight/2.2
	contentScreen.anchorX = 0.5
	contentScreen.anchorY = 0.5
	contentScreen:toBack()
	buttons:hideButtons()
	sceneGroup:insert(contentScreen)
	
	image = display.newImageRect("steps.png", display.actualContentWidth*1.35, display.actualContentHeight*0.84)
	image.anchorX = 0
	image.anchorY = 0
	image:toFront()
	image.x = display.contentCenterWidth
	image.x = image.x - display.contentWidth*0.22
	image.y = display.contentCenterHeight
	image.y = image.y+20
	sceneGroup:insert( image )
	
	level3 = display.newImageRect("level3label.png", 
						display.contentWidth*0.35, 
						display.contentHeight*0.08 )
	level3.x, level3.y = display.contentWidth*0.4, display.contentHeight*0.41
	level3.rotation = 35
	--level3.isVisible = false  -- FOR DEBUG
	level3.isHitTestable = true

	level2 = display.newImageRect("level2label.png", 
						display.contentWidth*0.47,
						display.contentHeight*0.08 )
	level2.x, level2.y = display.contentWidth*0.35, display.contentHeight*0.546
	level2.rotation = 10
	--level2.isVisible = false
	level2.isHitTestable = true

	level1 = display.newImageRect("level1label.png", 
						display.contentWidth*0.5,
						display.contentHeight*0.08 )
	level1.x, level1.y = display.contentWidth*0.37, display.contentHeight*0.69
	level1.rotation = -14
	--level1.isVisible = false
	level1.isHitTestable = true

	sceneGroup:insert( level1 )
	sceneGroup:insert( level2 )
	sceneGroup:insert( level3 )

	local title = display.newImageRect("mainm_title.png", display.contentWidth*0.9,display.contentHeight*0.1)
	title.x = display.contentWidth*0.5
	title.y = display.contentHeight/5

	sceneGroup:insert(title)

	level1:addEventListener("tap", function()
		p = {
		level = "1"
		}
		composer.gotoScene("levelmenu",{effect = "fade",time = 500, params=p})
	end)
	level2:addEventListener("tap", function()
		p = {
		level = "2"
		}
		composer.gotoScene("levelmenu",{effect = "fade",time = 500, params=p})
	end)
	level3:addEventListener("tap", function()
		p = {
		level = "3"
		}
		composer.gotoScene("levelmenu",{effect = "fade",time = 500, params=p})
	end)
	
	
	
	----print( "\n1: create event")
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		--print( "1: show event, phase did" )
	
		-- remove previous scene's view

		composer.removeHidden()

		
	
		
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		--print( "1: hide event, phase will" )

	
	end
	
end

function scene:destroy( event )
	--print( "((destroying scene 1's view))" )
	level1:removeSelf()
	level2:removeSelf()
	level3:removeSelf()
end

function scene:backPressed()
	-- body
	--print("backbtn touched")
end

function scene:nextPressed()
	-- body
	--print("nextbtn touched")
end

function scene:textPressed()
	-- body
	--print("textbtn touched")
end
---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene