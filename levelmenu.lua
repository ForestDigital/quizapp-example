----------------------------------------------------------------------------------
--
-- levelmenu.lua
-- Quizapp Example
-- App Open -> Level select -> Level Menu -> listen/read storyquizmenu -> listen/read storyquiz
----------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local buttons = require("hud")

local image, levelText, listenbutton, readbutton
---------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	local contentScreen = display.newImageRect( "content_screen.png", display.actualContentWidth, display.actualContentHeight*0.85)
	contentScreen.x, contentScreen.y = display.contentWidth/2, display.contentHeight/2.2
	contentScreen.anchorX = 0.5
	contentScreen.anchorY = 0.5

	contentScreen:toBack()
	sceneGroup:insert(contentScreen)

	image = display.newImageRect("background.png", display.actualContentWidth, display.actualContentHeight*0.84)
	image.anchorX = 0
	image.anchorY = 0
	image:toFront()
	image.x = display.contentCenterWidth
	image.x = image.x -1
	image.y = display.contentCenterHeight
	image.y = image.y+20


	sceneGroup:insert( image )


	if(event.params.level == "1") then
		levelText = display.newImageRect("level1label.png",
										 display.contentWidth*0.62,
										 display.contentHeight*0.1)
		levelText.x, levelText.y = display.contentWidth * 0.48, display.contentHeight*0.26
		sceneGroup:insert( levelText )
	end
	if(event.params.level == "2") then
		levelText = display.newImageRect("level2label.png",
										 display.contentWidth*0.62,
										 display.contentHeight*0.1)
		levelText.x, levelText.y = display.contentWidth * 0.48, display.contentHeight*0.26
		sceneGroup:insert( levelText )
	end
	if(event.params.level == "3") then
		levelText = display.newImageRect("level3label.png",
										 display.contentWidth*0.45,
										 display.contentHeight*0.1)
		levelText.x, levelText.y = display.contentWidth * 0.48, display.contentHeight*0.26
		sceneGroup:insert( levelText )
	end

	listenbutton = display.newImageRect("listen_stories_icon.png",
								   display.contentWidth*0.35,
								   display.contentHeight*0.35)
	listenbutton.x, listenbutton.y = display.contentWidth*0.28, display.contentHeight*0.62

	readbutton = display.newImageRect("read_stories_icon.png",
								   display.contentWidth*0.35,
								   display.contentHeight*0.35)
	readbutton.x, readbutton.y = display.contentWidth*0.72,
								   display.contentHeight*0.62


	sceneGroup:insert(listenbutton)
	sceneGroup:insert(readbutton)

	listenbutton:addEventListener("tap", function()
		p = {
		level = event.params.level
		}
		composer.gotoScene("listenstorymenu",{effect = "fade",time = 500, params=p})
	end)

	readbutton:addEventListener("tap", function()
		p = {
		level = event.params.level
		}
		composer.gotoScene("readstorymenu",{effect = "fade",time = 500, params=p})
	end)


end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		composer.removeHidden()
		buttons:showButtons()
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end


function scene:destroy( event )
	local sceneGroup = self.view

	image:removeSelf()
	levelText:removeSelf()
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

function scene:backPressed()
	-- body
	--print("backbtn touched")
	composer.gotoScene( "levelselect", "fade", 500 )
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