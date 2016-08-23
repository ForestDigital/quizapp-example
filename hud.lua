--This module adds the bottom buttons and listeners to the application
-- Including this module to other .lua files gives them access to the buttons
local widget = require "widget"
local composer = require "composer"
local hud = {}

local backbutton, nextbutton, textbutton

function hud:createButtons()
	local wh = display.contentWidth*0.16
	backbutton = widget.newButton
	{
		defaultFile = "arrow_left_off.png",
		overFile = "arrow_left_on.png",
		width=wh, height=wh
	}
	backbutton.x = 50
	backbutton.y = display.actualContentHeight*0.935

	--nextbutton = display.newImageRect("nextbutton.PNG", 50, 25)
	nextbutton = widget.newButton
	{
		defaultFile = "arrow_right_off.png",
		overFile = "arrow_right_on.png",
		width=wh, height=wh
	}
	nextbutton.x = display.actualContentWidth - 50
	nextbutton.y = display.actualContentHeight*0.935

	textbutton = widget.newButton
	{
		defaultFile = "back_to_text_off.png",
		overFile = "back_to_text_on.png",
		width=wh, height=wh
	}
	textbutton.x = display.actualContentWidth*0.5
	textbutton.y = display.actualContentHeight*0.935

	homebutton = widget.newButton
	{
		defaultFile = "home.png",
		overFile = "home.png",
		width = wh, height = wh
	}
	homebutton.x = (display.contentWidth - (wh*0.5))
	homebutton.y = (wh*0.75)

	backbutton:addEventListener('tap', function (event)
        if event.target == backbutton then
            local scene = composer.getScene(composer.getSceneName('current'))
            if scene and type(scene.backPressed) == 'function' then
                return scene:backPressed()
            end
        end 
    end); 

    nextbutton:addEventListener('tap', function (event)
        if event.target == nextbutton then
            local scene = composer.getScene(composer.getSceneName('current'))
            if scene and type(scene.nextPressed) == 'function' then
                return scene:nextPressed()
            end
        end 
    end); 

    textbutton:addEventListener('tap', function (event)
        if event.target == textbutton then
            local scene = composer.getScene(composer.getSceneName('current'))
            if scene and type(scene.textPressed) == 'function' then
                return scene:textPressed()
            end
        end 
    end); 

    homebutton:addEventListener('tap', function(event)
    	 if event.target == homebutton then
            local scene = composer.getScene(composer.getSceneName('current'))
            if scene and type(scene.homePressed) == 'function' then
                return scene:homePressed()
            else
            	composer.gotoScene("levelselect","fade",1000)
            end
        end 
    	
    end)

   	backbutton.alpha = 0
	nextbutton.alpha = 0
	textbutton.alpha = 0
	homebutton.alpha = 0

end

function hud:showButtons()
	if backbutton then
		transition.to(backbutton,{alpha = 1, time = 1000})
		transition.to(nextbutton,{alpha = 1, time = 1000})
		transition.to(textbutton,{alpha = 1, time = 1000})
		transition.to(homebutton,{alpha = 1, time = 1000})
	end
end

function hud:hideButtons()
	if backbutton then
		transition.to(backbutton,{alpha = 0, time = 1000})
		transition.to(nextbutton,{alpha = 0, time = 1000})
		transition.to(textbutton,{alpha = 0, time = 1000})
		transition.to(homebutton,{alpha = 0, time = 1000})
	end
end

return hud