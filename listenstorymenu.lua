----------------------------------------------------------------------------------
--
-- listenstorymenu.lua
--
----------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()
local image, icon, level, levelText
local tests
local scrollView

---------------------------------------------------------------------------------

function scene:create( event )
	local sceneGroup = self.view
	-- Called when the scene's view does not exist.
	local contentScreen = display.newImageRect( "content_screen.png", display.actualContentWidth, display.actualContentHeight*0.85)
	contentScreen.x, contentScreen.y = display.contentWidth/2, display.contentHeight/2.2
	contentScreen.anchorX = 0.5
	contentScreen.anchorY = 0.5
	contentScreen:toBack()
	sceneGroup:insert(contentScreen)

	image = display.newImageRect("main_title_step.png", display.actualContentWidth, display.actualContentHeight*0.84)
	image.anchorX = 0
	image.anchorY = 0
	image:toFront()
	image.x = display.contentCenterWidth
	image.x = image.x -1
	image.y = display.contentCenterHeight
	image.y = image.y+20

	icon = display.newImageRect("listen_stories_icon.png",
								display.actualContentWidth * 0.18,
								display.actualContentHeight * 0.16)
	icon.x = display.actualContentWidth*0.88
	icon.y = display.actualContentHeight*0.22



	sceneGroup:insert( image )
	if(event.params.level == "1") then
		--levelText = "Year 3 & 4"
		levelText = display.newImageRect("level1label.png",
										 display.contentWidth*0.62,
										 display.contentHeight*0.1)
		levelText.x, levelText.y = display.contentWidth * 0.48, display.contentHeight*0.26
		sceneGroup:insert( levelText )
		tests = require("level1audiotests")

	end
	if(event.params.level == "2") then
		levelText = display.newImageRect("level2label.png",
										 display.contentWidth*0.62,
										 display.contentHeight*0.1)
		levelText.x, levelText.y = display.contentWidth * 0.48, display.contentHeight*0.26
		sceneGroup:insert( levelText )
		tests = require("level2audiotests")

	end
	if(event.params.level == "3") then
		levelText = display.newImageRect("level3label.png",
										 display.contentWidth*0.45,
										 display.contentHeight*0.1)
		levelText.x, levelText.y = display.contentWidth * 0.48, display.contentHeight*0.26
		sceneGroup:insert( levelText )
		tests = require("level3audiotests")

	end
	sceneGroup:insert(icon)

	level = event.params.level
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	scrollView = widget.newScrollView(
    {
        x = display.contentWidth*0.5,
        y = display.contentHeight*0.62,
        width = display.contentWidth*0.95,
        height = display.contentHeight*0.45,
        scrollWidth = 600,
        scrollHeight = 800,
        horizontalScrollDisabled = true
    })	
    scrollView.anchorX = 0.5

    sceneGroup:insert(scrollView)

    for i=1, #tests do
    	if not( tests[i].levelType == nil ) then

			local button1 = display.newImageRect("questionBar.png",display.contentWidth*0.87, display.contentHeight*0.07)
			button1.x = display.contentWidth*0.45
			button1.y = display.contentHeight*0.1 + ((display.contentHeight*0.1)*(i-1))

			btOptions = {
			text = tests[i].name,
					x = display.contentWidth*0.45,
					y = display.contentHeight*0.1 + ((display.contentHeight*0.1)*(i-1)),
					font = native.systemFont
			}

			btnText = display.newText(	btOptions )
			btnText:setFillColor(0)
			scrollView:insert(button1)
			scrollView:insert(btnText)

			btnText:addEventListener("tap", function()
				local t = {currentTest = tests[i]}
				composer.gotoScene("listenquizscreen",{effect = "fade",time = 500, params=t})
			end)

    	end 
    end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

		composer.removeHidden()
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
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

function scene:backPressed()
	-- body
	p = {
		level = level
		}
	composer.gotoScene("levelmenu",{effect = "fade",time = 500, params=p})
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